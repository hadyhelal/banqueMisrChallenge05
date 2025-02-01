//
//  ErrorMessage.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import SwiftUI

struct ErrorMessage {
    let message: String
    var isVisible: Bool
}

struct ErrorModifier: ViewModifier {

    let errorMessagee: Binding<ErrorMessage>
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ErrorMessageView(errorMessage: errorMessagee)
                    .padding(.bottom, 20),
                alignment: .top
            )

    }
}

extension View {
    func errorMessage(errorMessage: Binding<ErrorMessage>) -> some View {
        self.modifier(ErrorModifier(errorMessagee: errorMessage))
    }
}
