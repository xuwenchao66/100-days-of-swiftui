//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 徐文超 on 2024/2/27.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .backgroundStyle(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.largeTitle).foregroundStyle(.red)
    }
}

struct GridStack <Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column).padding(6)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var isOK = true
    
    var body: some View {
        VStack {
            GridStack(rows: 4, columns: 4) { row, column in
                Text("\(row)-\(column)")
            }
            
            CapsuleText(text: "Damn")
            
            Text("I am title!").modifier(Title())
            
            Button("Hello, world!") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(isOK ? .yellow : .red)
            
            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
            
            VStack {
                Text("Gryffindor").font(.largeTitle).blur(radius: 0)
                Text("Hufflepuff")
            }
            .font(.title).blur(radius: 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
