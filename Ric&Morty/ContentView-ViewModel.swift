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
            self.fetchData()
        }
        
        var page = 1
        let totalPage = 41
        var isLoading = false
        
        
        func fetchData(){
            
            guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else { fatalError("wrong url") }
                
            // Добавляем параметр запроса 'page' для получения первой страницы
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { fatalError("wrong URL Components") }
            components.queryItems = [
                URLQueryItem(name: "page", value: String(page))
            ]
            
            
            let task = URLSession.shared.dataTask(with: components.url!) { data, _, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let data = data {
                    do {
                        let characters = try JSONDecoder().decode(Results.self, from: data)
                        for character in characters.results {
                            self.characterArr.append(character)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            task.resume()
            self.page+=1
        }
        
        func loadMore(id: Int) {
            if let lastChar = characterArr.last, lastChar.id == id {
                isLoading = true
                fetchData()
                isLoading = false
            }
        }
    }
}
