//
//  EditCards.swift
//  Flashzilla
//
//  Created by 徐文超 on 2024/5/5.
//

import SwiftUI

struct EditCards: View {
    @Environment (\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var prompt = ""
    @State private var answer = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Promot", text: $prompt)
                    TextField("answer", text: $answer)
                    Button("Add Card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done") { dismiss() }
            }
            .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }

    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func addCard () {
        let formmattedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        let formmattedAnswer = answer.trimmingCharacters(in: .whitespaces)
        guard formmattedPrompt.isEmpty == false && formmattedAnswer.isEmpty == false else { return }
        cards.insert(Card(prompt: prompt, answer: answer), at: 0)
        saveData()
    }
    
    func removeCards(_ offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

#Preview {
    EditCards()
}
