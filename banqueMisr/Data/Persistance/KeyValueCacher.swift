//
//  KeyValueCacher.swift
//  banqueMisr
//
//  Created by Hady Helal on 01/02/2025.
//

import UIKit

struct KeyValueCacher {
    static func saveImageLink(link: String) {
        UserDefaults.standard.set(link, forKey: "imagesLink")
    }
    
    static func getImageLink() -> String? {
        UserDefaults.standard.string(forKey: "imagesLink")
    }
}
