//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Austin Trumbly on 6/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.requestReview) var requestReview
    
    var shouldRequestReview: Bool {
        dataController.count(for: Tag.fetchRequest()) >= 5
    }

    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(dataController.issuesForSelectedFilter()) { issue in
                IssueRowView(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issues")
        /* Need to figure out why tag/tokens are not working below in searchable... 
         For now taking out that functionality.
         Should read "Filter issues, or type # to add tags"*/
        .searchable(text: $dataController.filterText, 
            tokens: $dataController.filterTokens,
            suggestedTokens: .constant(dataController.suggestedFilterTokens),
            prompt: "Filter issues"
        ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: ContentViewToolbar.init)
        .onAppear(perform: askForReview)
        .onOpenURL(perform: openURL)
    }
    
//    init(dataController: DataController) {
//        let viewModel = ViewModel(dataController: dataController)
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }

    func delete(_ offsets: IndexSet) {
        let issues = dataController.issuesForSelectedFilter()

        for offset in offsets {
            let item = issues[offset]
            dataController.delete(item)
        }
    }
    
    func askForReview() {
        if shouldRequestReview {
            requestReview()
        }
    }
    
    func openURL(_ url: URL) {
        if url.absoluteString.contains("newIssue") {
            dataController.newIssue()
        }
    }
}
