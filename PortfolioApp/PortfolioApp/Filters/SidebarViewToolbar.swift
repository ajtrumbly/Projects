//
//  SidebarViewToolbar.swift
//  PortfolioApp
//
//  Created by Austin Trumbly on 6/14/24.
//

import SwiftUI

struct SidebarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @Binding var showingAwards: Bool
    @State private var showingStore = false
    
    var body: some View {
        Button(action: tryNewTag) {
            Label("Add tag", systemImage: "plus")
        }
        .sheet(isPresented: $showingStore, content: StoreView.init)
        
        Button {
            showingAwards.toggle()
        } label: {
            Label("Show awards", systemImage: "rosette")
        }
        
        #if DEBUG
        Button {
            dataController.deleteAll()
            dataController.createSampleData()
        } label: {
            Label("Add Samples", systemImage: "flame")
        }
        #endif
    }
    
    func tryNewTag() {
        if dataController.newTag() == false {
            showingStore = true
        }
    }
}

#Preview {
    SidebarViewToolbar(showingAwards: .constant(true))
}
