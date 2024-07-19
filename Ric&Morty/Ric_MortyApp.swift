//
//  Ric_MortyApp.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import SwiftUI
import SwiftData

@main
struct Ric_MortyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Favorites.self)
    }
}
