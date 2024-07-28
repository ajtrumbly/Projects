//
//  TransactionView.swift
//  GiftCardWallet
//
//  Created by Austin Trumbly on 7/16/24.
//

import SwiftUI
import SwiftData

struct TransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    
    @Bindable var giftCard: GiftCard
    @State private var date = Date.now
    @State private var notes = ""
    @State private var amount = 0.0
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
            case store, amount, notes
        }
    
    var body: some View {
        Form {
            TextField("", text: $notes, prompt: Text("Add a note"))
                .focused($focusedField, equals: .notes)
            
            HStack(spacing: 0) {
                Text("$")
                TextField("", value: $amount, format: .number.precision(.fractionLength(2)), prompt: Text("Enter transaction amount"))
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .amount)
                
                Image(systemName: "giftcard.fill")
            }
            
            DatePicker("Transaction Date", selection: $date)
                .pickerStyle(.automatic)
            
            Section {
                HStack {
                    Spacer()
                    Button("Save") {
                        let transaction = Transaction(amount: amount, date: date, notes: notes, giftCard: giftCard)
                        giftCard.balance -= amount
                        modelContext.insert(transaction)
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
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

#Preview {
    TransactionView(giftCard: .example)
}
