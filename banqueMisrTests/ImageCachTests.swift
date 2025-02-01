//
//  ImageCachTests.swift
//  banqueMisr
//
//  Created by Hady Helal on 01/02/2025.
//

import XCTest
import Foundation

@testable import banqueMisr

final class ImageCachTests: XCTestCase {
    
    var sut: ImageCacheManager!
    
    override func setUp() {
        
        sut = ImageCacheManager()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testImageSaving() {
        guard let testImageLink = URL(string: "https://picsum.photos/200") else {
            return
        }
        sut.cacheImage(.actions, for: testImageLink)
        
        let image = sut.loadImage(from: testImageLink)
        
        XCTAssertNotNil(image)
    }
    
    
}
