//
//  WelcomeView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to Rick & Morty app")
                .font(.largeTitle)
            
            Text("Please select a character from the left-hand menu; swipe from the left edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
