//
//  Helper.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation
import UIKit.UIDevice
import SystemConfiguration

enum Helper {
    static var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var baseURL = "https://api.themoviedb.org/3/"
    
    static var imagesURL = ""
    
    static var token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODg2OTE0YjY2OGRjZDcwYmYyZGM5ZjQ2NmQ0NWE4NiIsIm5iZiI6MTczODMzODc5OC42NjQsInN1YiI6IjY3OWNmMWVlODIyZTdkMzJmN2JkZmE2ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-d5mOmp_7B6j_DgOUCqKDy_33ejvh4KxPe6Bw2Ut5Vw"
    
}
