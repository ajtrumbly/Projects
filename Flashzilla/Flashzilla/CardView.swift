//
//  CardView.swift
//  Flashzilla
//
//  Created by Austin Trumbly on 5/6/24.
//

import SwiftUI

extension Shape {
    func fill(using offset: CGSize) -> some View {
        if offset.width == 0 {
            self.fill(.white)
        } else if offset.width < 0 {
            self.fill(.red)
        } else {
            self.fill(.green)
        }
    }
}

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var isShowingAnswer = false
    @State private var offSet = CGSize.zero
    
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offSet.width / 50))))
                .background(
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fill(using: offSet)
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offSet.width / 5.0))
        .offset(x: offSet.width * 5)
        .opacity(2 - Double(abs(offSet.width / 25)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offSet = gesture.translation
                }
                .onEnded { _ in
                    if abs(offSet.width) > 100 {
                        if offSet.width > 0 {
                            removal?(false)
                        } else {
                            removal?(true)
                        }
                    } else {
                        offSet = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.default, value: offSet)
    }
}

#Preview {
    CardView(card: .example)
}
