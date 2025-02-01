//
//  ShimmerEffect.swift
//  banqueMisr
//
//  Created by Hady Helal on 31/01/2025.
//


import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    private let gradientColors = [Color.gray.opacity(0.15), Color.white.opacity(0.2), Color.gray.opacity(0.15)]
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(colors: gradientColors, startPoint: startPoint, endPoint: endPoint)
                    .mask(content)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                            startPoint = .init(x: 1, y: 1)
                            endPoint = .init(x: 2.2, y: 2.2)
                        }
                    }
            )
    }
}

struct ShimmeringRedactionModifier: ViewModifier {
    private let shouldRedact: Bool
    
    init(shouldRedact: Bool) {
        self.shouldRedact = shouldRedact
    }
    
    func body(content: Content) -> some View {
        if shouldRedact {
            content
                .redacted(reason: .placeholder)
                .shimmer()
        } else {
            content
        }
    }
}

extension View {
    func shimmeringRedact(shouldRedact: Bool) -> some View {
        modifier(ShimmeringRedactionModifier(shouldRedact: shouldRedact))
    }
    
    func shimmer() -> some View {
        modifier(ShimmerEffect())
    }
}
