//
//  ImageLoader.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//


import SwiftUI

struct ImageLoaderr<Placeholder: View>: View {
    
    let url: String
    var contentMode: SwiftUI.ContentMode = .fill
    var placeholder: () -> Placeholder
    
    init(
        url: String,
        contentMode: SwiftUI.ContentMode = .fill,
        placeholder: @escaping () -> Placeholder = { ProgressView() }
    ) {
        self.url = url
        self.contentMode = contentMode
        self.placeholder = placeholder
    }
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                } placeholder: {
                    placeholder()
                }
                .allowsHitTesting(false)
            }
            .clipped()
    }
}

struct ImageLoader<Placeholder: View>: View {
    
    @EnvironmentObject var imageCacheManager: ImageCacheManager
    
    let url: String
    var contentMode: SwiftUI.ContentMode = .fill
    var placeholder: () -> Placeholder
    
    @State private var cachedImage: UIImage?

    init(
        url: String,
        contentMode: SwiftUI.ContentMode = .fill,
        placeholder: @escaping () -> Placeholder = { ProgressView() }
    ) {
        self.url = url
        self.contentMode = contentMode
        self.placeholder = placeholder
    }
    
    var body: some View {
        
        Rectangle()
            .opacity(0)
            .overlay {
                
                Group {
                    
                    if let uiImage = cachedImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                    } else {
                        AsyncImage(url: URL(string: url)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: contentMode)
                                    .onAppear {
                                        saveImageToCache(image)
                                    }
                            default:
                                placeholder()
                            }
                        }
                        
                    }
                }
                .allowsHitTesting(false)
            }
            .clipped()
        .onAppear {
            loadCachedImage()
        }
    }
    
    private func loadCachedImage() {
        if let url = URL(string: url) {
            cachedImage = imageCacheManager.loadImage(from: url)
            print("Image Loaded..")
        }
    }
    
    private func saveImageToCache(_ image: Image) {
        guard let url = URL(string: url) else { return }
        let uiImage = image.asUIImage()
        imageCacheManager.cacheImage(uiImage, for: url)
    }
}
