//
//  CardOverlayView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/4/24.
//

import SwiftUI

struct CardOverlayView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width * 0.8
            let height = width * (53.98 / 85.60) // Standard credit card aspect ratio
            let x = (geometry.size.width - width) / 2
            let y = (geometry.size.height - height) / 2
            let cornerRadius: CGFloat = 10
            
            Path { path in
                let rect = CGRect(x: x, y: y, width: width, height: height)
                path.addRoundedRect(in: rect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
            }
            .stroke(Color.white, lineWidth: 3)
            .background(Color.black.opacity(0.5))
            .mask(
                Path { path in
                    path.addRect(geometry.frame(in: .local))
                    let rect = CGRect(x: x, y: y, width: width, height: height)
                    path.addRoundedRect(in: rect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
                }
                .fill(style: FillStyle(eoFill: true))
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CardOverlayView()
}
