//
//  ImageCacheManager.swift
//  banqueMisr
//
//  Created by Hady Helal on 01/02/2025.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func loadImage(from url: URL?) -> UIImage?
    func cacheImage(_ image: UIImage, for url: URL)
}

struct CachePolicy {
    static let expirationDays: Int = 5
    static var expirationInterval: TimeInterval {
        return TimeInterval(expirationDays * 24 * 60 * 60) // 5 days in seconds
    }
}

final class ImageCacheManager: ObservableObject, ImageCacheProtocol {
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager: FileManager
    private let cacheDirectory: URL
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("ImageCache")
        createCacheDirectory()
        clearExpiredCache()
    }
    
    func loadImage(from url: URL?) -> UIImage? {
        guard let url else { return nil }
        let cacheKey = url.absoluteString as NSString
        
        if let cachedImage = memoryCache.object(forKey: cacheKey) {
            return cachedImage
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        if let image = loadImageFromDisk(fileURL: fileURL) {
            memoryCache.setObject(image, forKey: cacheKey)
            return image
        }
        
        return nil
    }
    
    func cacheImage(_ image: UIImage, for url: URL) {
        let cacheKey = url.absoluteString as NSString
        memoryCache.setObject(image, forKey: cacheKey)
        
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        saveImageToDisk(image, fileURL: fileURL)
    }
    
    private func clearExpiredCache() {
        do {
            let files = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: [.contentModificationDateKey])
            let expirationDate = Date().addingTimeInterval(-CachePolicy.expirationInterval)
            
            for fileURL in files {
                if let attributes = try? fileManager.attributesOfItem(atPath: fileURL.path),
                   let modificationDate = attributes[.modificationDate] as? Date,
                   modificationDate < expirationDate {
                    try fileManager.removeItem(at: fileURL)
                }
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    private func createCacheDirectory() {
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    private func saveImageToDisk(_ image: UIImage, fileURL: URL) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            do {
                try data.write(to: fileURL, options: .atomic)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    private func loadImageFromDisk(fileURL: URL) -> UIImage? {
        guard fileManager.fileExists(atPath: fileURL.path) else { return nil }
        return UIImage(contentsOfFile: fileURL.path)
    }
}
