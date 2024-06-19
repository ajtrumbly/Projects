//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Austin Trumbly on 6/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController

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
    }

    func delete(_ offsets: IndexSet) {
        let issues = dataController.issuesForSelectedFilter()

        for offset in offsets {
            let item = issues[offset]
            dataController.delete(item)
        }
    }
}

#Preview {
    ContentView()
}
