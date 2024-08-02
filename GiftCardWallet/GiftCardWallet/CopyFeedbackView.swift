//
//  CopyFeedbackView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 8/1/24.
//

import SwiftUI

struct CopyFeedbackView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Copied!")
                .padding(8)
                .background(Color.primary.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(8)
                .transition(.scale.combined(with: .opacity))
        }
        .frame(height: .infinity)
    }
}

#Preview {
    CopyFeedbackView()
}
