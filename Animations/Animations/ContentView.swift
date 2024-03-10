//
//  ContentView.swift
//  Animations
//
//  Created by 徐文超 on 2024/3/10.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Show Rectangle") {
                withAnimation{
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle().fill(.red).frame(width: 100, height: 100).transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
            Button("Tap Me") {}
                .padding(50)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(animationAmount)
                        .opacity(2 - animationAmount)
                        .animation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                            value: animationAmount
                        )
                )
                .onAppear {
                    animationAmount = 2
                }
                .animation(.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true), value: animationAmount)
            
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
