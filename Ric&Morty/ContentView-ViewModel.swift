//
//  ContentView-ViewModel.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
        
        var characterArr: [Character]
        
        init() {
            self.characterArr = []
        }
        
        
        func fetchData(){
            
            let url = URL(string: "https://rickandmortyapi.com/api/character/")!
                
            // Добавляем параметр запроса 'page' для получения первой страницы
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = [
                URLQueryItem(name: "page", value: "1")
            ]
            
            
            let task = URLSession.shared.dataTask(with: components.url!) { data, _, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let data = data {
                    do {
                        let characters = try JSONDecoder().decode(Results.self, from: data)
                        self.characterArr = []
                        for character in characters.results {
                            self.characterArr.append(character)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            task.resume()

        }
    }
}
