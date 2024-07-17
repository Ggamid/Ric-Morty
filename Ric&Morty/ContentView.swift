//
//  ContentView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var character: Character? = nil
    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationSplitView {
            
            ScrollView{
                
                VStack(spacing: 0){
                    ForEach(viewModel.characterArr, id: \.id) { character in
                        CharacterRow(character: character)
                    }
                }
            }
            .navigationTitle("Rick & Morty Characters")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                viewModel.fetchData()
            }
            
        } detail: {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}
