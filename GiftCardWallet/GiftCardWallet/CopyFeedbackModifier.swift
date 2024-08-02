//
//  CopyFeedbackModifier.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 8/1/24.
//
import SwiftUI

struct CopyFeedbackModifier: ViewModifier {
    let textToCopy: String
    @State private var isCopied = false
    
    func body(content: Content) -> some View {
        content
            .onLongPressGesture(minimumDuration: 0.5) {
                UIPasteboard.general.string = textToCopy
                withAnimation {
                    isCopied = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isCopied = false
                    }
                }
            }
            .overlay(
                Group {
                    if isCopied {
                        CopyFeedbackView()
                    }
                }
            )
    }
}
