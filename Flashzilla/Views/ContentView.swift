//
//  ContentView.swift
//  Flashzilla
//
//  Created by Jiaming Guo on 2022-12-26.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        CardView(card: Card.example)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
