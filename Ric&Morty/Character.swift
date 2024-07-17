//
//  Person.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import Foundation
import SwiftUI

struct Results: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var statusColor: Color {
        switch self.status {
        case "Alive":
            Color.greenCustom
        case "Dead":
            Color.redCustom
        case "unknown":
            Color.gray
        default:
            Color.black
        }
    }
    
    
    var displayingEpisodes: Set<String> {
        var seOfEpisodes = Set<String>()
        let epi = episode.compactMap { $0.last.map { String($0) } }
        for ep in epi {
            seOfEpisodes.insert(ep)
        }
        return seOfEpisodes
    }
    
    static let example = Character(
            id: 183,
            name: "Johnny Depp",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Origin(
                name: "Earth (C-500A)",
                url: "https://rickandmortyapi.com/api/location/23"
            ),
            location: Location(
                name: "Earth (C-500A)",
                url: "https://rickandmortyapi.com/api/location/23"
            ),
            image: "https://rickandmortyapi.com/api/character/avatar/183.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/8"],
            url: "https://rickandmortyapi.com/api/character/183",
            created: "2017-12-29T18:51:29.693Z"
        )
    
}

// Модель данных
struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}
