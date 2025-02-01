//
//  ToastMessageView.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//

import SwiftUI

struct ErrorMessageView: View {

    @Binding var errorMessage: ErrorMessage
    
    @State private var timerStarted = false

    var body: some View {
        Text(errorMessage.message)
            .font(.callout)
            .foregroundStyle(Color.errorText)
            .multilineTextAlignment(.leading)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.errorBackground)
            .mask {
                RoundedRectangle(cornerRadius: 8)
            }
            .padding()
            .offset(y: errorMessage.isVisible ? 0 : -UIScreen.main.bounds.height)
            .opacity(errorMessage.isVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: errorMessage.isVisible)
            .onChange(of: errorMessage.isVisible) { _, newValue in
                if newValue && !timerStarted {
                    timerStarted = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        errorMessage.isVisible = false
                        timerStarted = false
                    }
                }
            }

    }
}
