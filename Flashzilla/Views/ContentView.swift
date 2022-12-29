//
//  ContentView.swift
//  Flashzilla
//
//  Created by Jiaming Guo on 2022-12-26.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = total - position
        return self.offset(x: 0, y: CGFloat(offset * 10))
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColour
    @Environment(\.scenePhase) var scenePhase
    @State private var cards = [Card](repeating: Card.example, count: 10)
    @State private var timeRemaining = 100
    @State private var isActive = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                if differentiateWithoutColour {
                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                            Spacer()
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                    }
                }
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                    }
                }
            }
        }
        .onReceive(timer) { time in
            if timeRemaining > 0 {
                guard isActive else { return }
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            isActive = newPhase == .active
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
