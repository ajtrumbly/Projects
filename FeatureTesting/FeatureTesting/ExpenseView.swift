//
//  ExpenseView.swift
//  FeatureTesting
//
//  Created by Austin Trumbly on 7/24/24.
//

import SwiftUI

struct Expense: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var amount: String
    var date: String
}

struct ExpenseView: View {
    let expenses: [Expense] = [
        Expense(name: "Walmart", category: "Food", amount: "$100", date: "1/1/2024"),
        Expense(name: "Amazon", category: "Home", amount: "$150", date: "3/1/2024"),
        Expense(name: "Apple", category: "Technology", amount: "$999", date: "6/1/2024"),
        Expense(name: "Best Buy", category: "Technology", amount: "$250", date: "7/1/2024"),
        Expense(name: "Scheels", category: "Clothing", amount: "$600", date: "2/1/2024"),
        Expense(name: "Circle K", category: "Gas", amount: "$45", date: "11/1/2024"),
        Expense(name: "Trader Joes", category: "Food", amount: "$180", date: "9/1/2024"),
    ]
    @Binding var show: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(expenses.indices, id: \.self) { index in
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Text(expenses[index].name)
                                .font(.headline)
                            Text(expenses[index].category)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(expenses[index].amount)
                                .font(.headline)
                            Text(expenses[index].date)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .foregroundStyle(.black)
                    .offset(y: show ? 0 : CGFloat(index * 100))
                    .opacity(show ? 1 : 0)
                    .animation(.spring(duration: Double(index) * 0.15), value: show)
                    .padding()
                }
            }
            .padding(10)
        }
        .scrollIndicators(.hidden)
        .background(.white, in: .rect(cornerRadius: 16))
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        .padding(.horizontal, 20)
    }
}

//#Preview {
//    ExpenseView()
//}
