//
//  IssueViewToolbar.swift
//  PortfolioApp
//
//  Created by Austin Trumbly on 6/14/24.
//

import SwiftUI

struct IssueViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    
    var openCloseButtonText: LocalizedStringKey {
        issue.completed ? "Re-open Issue" : "Close Issue"
    }
    
    var body: some View {
        Menu {
            Button {
                UIPasteboard.general.string = issue.title
            } label: {
                Label("Copy Issue Title", systemImage: "doc.on.doc")
            }
            
            Button(action: toggleCompleted) {
                Label(openCloseButtonText, systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
            .sensoryFeedback(trigger: issue.completed) { oldValue, newValue in
                if newValue {
                    .success
                } else {
                    nil
                }
            }
            
            Divider()
            
            Section("Tags") {
                TagsMenuView(issue: issue)
            }
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }
    
    func toggleCompleted() {
        issue.completed.toggle()
        dataController.save()
    }
}

#Preview {
    IssueViewToolbar(issue: Issue.example)
}
