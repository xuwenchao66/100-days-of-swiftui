//
//  ContentView.swift
//  WeSplit
//
//  Created by 徐文超 on 2024/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    let currentFormatCode = Locale.current.currency?.identifier ?? "USD"
    
    var totalAmount: Double {
        let selectedTip = Double(tipPercentage)
        let tipValue = checkAmount / 100 * selectedTip
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let personCount = Double(numberOfPeople + 2)
        return totalAmount / personCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currentFormatCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: currentFormatCode))
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: currentFormatCode))
                }
            }.navigationTitle("We Split").toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

