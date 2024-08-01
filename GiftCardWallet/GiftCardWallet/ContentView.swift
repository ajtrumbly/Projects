//
//  ContentView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/2/24.
//

import SwiftUI
import SwiftData 

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        WalletView()
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
       return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
