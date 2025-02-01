//
//  BaseViewModel.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var isLoading = false
    
    @Published var errorMessage: ErrorMessage = ErrorMessage(message: "", isVisible: false)

    func handleError(_ error: Error) {
        errorMessage = ErrorMessage(message: error.errorMessage, isVisible: true)
        print("\(error.errorMessage)")
    }
}
