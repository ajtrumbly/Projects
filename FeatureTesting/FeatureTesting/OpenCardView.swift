//
//  OpenCardView.swift
//  FeatureTesting
//
//  Created by Austin Trumbly on 7/24/24.
//

import SwiftUI

struct OpenCardView: View {
    @Binding var close: Bool
    @State private var show = false
    var data: CardMode
    var namespace: Namespace.ID
    @Namespace var namespace2
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack{
                CardView(data: data, namespace: namespace)
                    .matchedGeometryEffect(id: data.id, in: namespace)
                    .onTapGesture {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.spring(duration: 0.1)) {
                                close = false
                            }
                        }
                        withAnimation(.spring(duration: 0.4)) {
                            show = false
                        }
                    }
                ExpenseView(show: $show)
                    .offset(y: show ? 0 : 400)
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(duration: 0.4)) {
                    show = true
                }
            }
        }
        .onDisappear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(duration: 0.4)) {
                    show = true
                }
            }
        }
        .onChange(of: show) { old, newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if newValue {
                    withAnimation(.spring(duration: 0.4)) {
                        show = true
                    }
                }
            }
        }
    }
}

//#Preview {
//    OpenCardView()
//}
#Preview {
    ContentView()
}
