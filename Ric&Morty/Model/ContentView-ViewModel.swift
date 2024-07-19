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
        
        var page = 1
        let totalPage = 41
        var isLoadingScreenShowed = false
        
        var statusFilter: Status = .none
        var genderFilter: Gender = .none
        
        var searchReq = ""
        
        init() {
            self.characterArr = []
            self.fetchData()
        }
        
        var filteredCharacterList: [Character] {
            var resArr = [Character]()
            if genderFilter != .none && statusFilter != .none && !searchReq.isEmpty {
                resArr = characterArr.filter { $0.gender == genderFilter.rawValue && $0.status == statusFilter.rawValue && $0.name.localizedStandardContains(searchReq)
                }
            } else if genderFilter != .none && statusFilter != .none {
                resArr = characterArr.filter { $0.gender == genderFilter.rawValue && $0.status == statusFilter.rawValue }
            } else if genderFilter != .none {
                resArr = characterArr.filter { $0.gender == genderFilter.rawValue }
            } else if statusFilter != .none {
                resArr = characterArr.filter { $0.status == statusFilter.rawValue }
            } else if !searchReq.isEmpty{
                resArr = characterArr.filter{ $0.name.localizedStandardContains(searchReq) }
            } else {
                resArr = characterArr
            }

            return resArr
        }
        
        func fetchData(){
            guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else { fatalError("wrong url") }
                
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
                fetchData()
            }
        }
        
        func showLoadingScreen() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isLoadingScreenShowed = true
            }
        }
    }
}
