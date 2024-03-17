//
//  AddView.swift
//  iExpense
//
//  Created by 徐文超 on 2024/3/17.
//
import SwiftUI

struct AddView : View {
    var expenses: Expenses
    @Environment(\.dismiss) var dissmiss
    @State private var name = ""
    @State private var type = types[0]
    @State private var amount = 0.0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD")).keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dissmiss()
                }
            }
        }
    }
}
