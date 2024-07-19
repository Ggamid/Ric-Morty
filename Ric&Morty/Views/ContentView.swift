//
//  ContentView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    

    
    @State var showFilterView = false
    
    @StateObject var network = NetworkMonitor()
    


    var body: some View {
        NavigationSplitView {
            ZStack{
                VStack {
                    Text("Rick & Morty Characters")
                        .font(.title)
                        .bold()
                        .padding(.top)
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.leading)
                                .foregroundStyle(.gray)
                            TextField("Search", text: $viewModel.searchReq)
                        }
                        .frame(height: 50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray.opacity(0.5), lineWidth: 2)
                        }
                        .padding(.horizontal)
                        Button{
                            showFilterView = true
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .font(.title)
                                .padding(.trailing)
                                .padding(.leading, 3)
                                .foregroundStyle(.cyan)
                                
                        }
                    }
                    HStack{
                        if viewModel.statusFilter != .none {
                            Text(viewModel.statusFilter.rawValue)
                                .filterMod(textColor: .black, backgroundColor: .white)
                        }
                        
                        if viewModel.genderFilter != .none {
                            Text(viewModel.genderFilter.rawValue)
                                .filterMod(textColor: .black, backgroundColor: .white)
                        }
                        
                        if viewModel.genderFilter != .none || viewModel.statusFilter != .none {
                            Button{
                                withAnimation {
                                    viewModel.genderFilter = .none
                                    viewModel.statusFilter = .none
                                }
                            } label: {
                                Text("Reset all filters")
                                    .filterMod(textColor: .white, backgroundColor: .cyan)
                            }
                            Spacer()
                        }
                    }
                    .padding(.top)
                    .padding(.leading)
                    
                    ScrollView{
                        LazyVStack(spacing: 0){
                            if !viewModel.filteredCharacterList.isEmpty{
                                ForEach(viewModel.filteredCharacterList, id: \.id) { character in
                                    NavigationLink {
                                        DetailView(character: character)
                                    } label: {
                                        CharacterRow(character: character)
                                    }
                                    .padding(.top, -5)
                                    .onAppear{
                                        viewModel.loadMore(id: character.id)
                                    }
                                }
                            } else {
                                NothinFoundView()
                            }
                        }
                        .scrollTargetLayout()
                        .padding()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }
                
                if !network.isConnected {
                    NetworkErrorView(task: viewModel.fetchData )
                }
                
                if !viewModel.isLoadingScreenShowed {
                    LoadingView()
                }
            }
            
        } detail: {
            WelcomeView()
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showFilterView, content: {
            FilterView(statusFilter: $viewModel.statusFilter, genderFilter: $viewModel.genderFilter, favoriteFilter: $viewModel.filterByFavorite)
                .presentationDetents([.height(400)])
        })
        .onAppear(perform: {
            withAnimation {
                viewModel.showLoadingScreen()
            }
        })
        
    }
}

#Preview {
    ContentView()
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
    case none = "None"
}

enum Status: String, CaseIterable {
    case dead = "Dead"
    case alive = "Alive"
    case unknown = "unknown"
    case none = "None"
}

struct FilterMod: ViewModifier {
    var textColor: Color
    var backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .foregroundStyle(textColor)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View {
    func filterMod(textColor: Color, backgroundColor: Color) -> some View{
        modifier(FilterMod(textColor: textColor, backgroundColor: backgroundColor))
    }
}
