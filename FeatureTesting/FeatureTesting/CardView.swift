//
//  CardView.swift
//  FeatureTesting
//
//  Created by Austin Trumbly on 7/24/24.
//

import SwiftUI

struct CardMode: Identifiable {
    var id = UUID()
    var creditID = UUID()
    var tColor: Color
    var bColor: Color
    var name: String
    var num: String
}

struct CardView: View {
    var data: CardMode
    var namespace: Namespace.ID
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 26) {
                Text("Credit")
                    .matchedGeometryEffect(id: data.creditID, in: namespace)
                Spacer()
                Text(data.name)
                    .matchedGeometryEffect(id: data.name, in: namespace)
                Text(data.num)
                    .matchedGeometryEffect(id: data.num, in: namespace)
            }
            .font(.title3)
            .foregroundStyle(.black)
            Spacer()
            Image(systemName: "creditcard")
                .renderingMode(.template)
                .resizable().scaledToFit()
                .foregroundColor(.black)
                .frame(width: 60, height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(LinearGradient(colors: [data.tColor, data.bColor], startPoint: .topLeading, endPoint: .bottomTrailing), in: .rect(cornerRadius: 20))
        .padding(.horizontal, 20)
    }
}

#Preview {
    ContentView()
}
