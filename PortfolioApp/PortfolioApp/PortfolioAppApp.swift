//
//  PortfolioAppApp.swift
//  PortfolioApp
//
//  Created by Austin Trumbly on 6/3/24.
//

import SwiftUI

@main
struct PortfolioAppApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
