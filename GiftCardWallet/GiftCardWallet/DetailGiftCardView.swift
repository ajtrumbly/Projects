//
//  DetailGiftCardView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/3/24.
//

import SwiftUI
import SwiftData

struct DetailGiftCardView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var giftCard: GiftCard
    @State private var showingDelete = false
    @State private var showingTransaction = false
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
            case store, balance
        }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text(giftCard.store)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Button(action: {
                        showingDelete = true
                    }) {
                        Image(systemName: "trash")
                            .font(.title2)
                    }
                    .padding()
                }
                .background(Color(UIColor.systemBackground))
                
                Form {
                    Section("Card Details") {
                        TextField("Enter the name of the store", text: $giftCard.store)
                            .focused($focusedField, equals: .store)
                        HStack(spacing: 0) {
                            Text("$")
                            TextField("Enter the balance", value: $giftCard.balance, format: .number.precision(.fractionLength(2)))
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .balance)
                        }
                    }
                    
                    Section("Scan Card") {
                        GenerateBarcodeView(giftCard: giftCard)
                    }

                    Section("Transactions") {
                        Button("Add Test Transaction") {
                            showingTransaction = true
                        }
                        
                        let sortedTransactions = giftCard.transactions.sorted { $0.date > $1.date }
                        
                        if sortedTransactions.isEmpty {
                            Text("No transactions yet")
                        } else {
                            ForEach(sortedTransactions) { transaction in
                                HStack {
                                    Text(transaction.date, style: .date)
                                    Spacer()
                                    Text(String(format: "$%.2f", transaction.amount))
                                    if let notes = transaction.notes {
                                        Text(notes)
                                    }
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
            }
        }
        .alert("Delete Gift Card", isPresented: $showingDelete) {
            Button("Delete", role: .destructive, action: deleteCard)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this gift card? This action cannot be undone.")
        }
        .sheet(isPresented: $showingTransaction) {
            TransactionView(giftCard: giftCard)
                .presentationDetents([.medium])
        }
    }
    
    func deleteCard() {
        modelContext.delete(giftCard)
        dismiss()
    }
}
#Preview {
    DetailGiftCardView(giftCard: .example)
}
