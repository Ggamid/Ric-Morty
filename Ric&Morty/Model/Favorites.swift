//
//  Favorites.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 19.07.2024.
//

import Foundation
import SwiftData

@Model
class Favorites {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    static func isContained(id: Int, list: [Favorites]) -> Bool {
        for fav in list {
            if id == fav.id {
                return true
            }
        }
        return false
    }
    
    static func findFav(id: Int, list: [Favorites]) -> Int {
        for i in 0..<list.count {
            if list[i].id == id {
                return i
            }
        }
        return -1
    }
    
}
