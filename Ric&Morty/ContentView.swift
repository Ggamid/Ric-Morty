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
    @State private var searchReq = ""
    
    @State var statusFilter: Status = .none
    @State var genderFilter: Gender = .none
    
    @State var showFilterView = false

    var body: some View {
        NavigationSplitView {
            
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.leading)
                        TextField("Search", text: $searchReq)
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
                            .foregroundStyle(.white)
                    }
                }
                HStack{
                    if statusFilter != .none {
                        Text(statusFilter.rawValue)
                            .filterMod(textColor: .black, backgroundColor: .white)

                    }
                    
                    if genderFilter != .none {
                        Text(genderFilter.rawValue)
                            .filterMod(textColor: .black, backgroundColor: .white)

                    }
                    
                    if genderFilter != .none || statusFilter != .none {
                        Button{
                            withAnimation {
                                genderFilter = .none
                                statusFilter = .none
                            }

                        } label: {
                            Text("Reset all filters")
                                .filterMod(textColor: .white, backgroundColor: .blue)
                        }
                        Spacer()
                    }
                    
                }
                .padding(.top)
                .padding(.leading)
                ScrollView{
                    VStack(spacing: 0){
                        ForEach(viewModel.characterArr, id: \.id) { character in
                            NavigationLink {
                                DetailView(character: character)
                            } label: {
                                CharacterRow(character: character)
                            }
                            .padding(.top, -5)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Rick & Morty Characters")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear{
                    
                    viewModel.fetchData()
            }
            }
            
        } detail: {
            WelcomeView()
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showFilterView, content: {
            FilterView(statusFilter: $statusFilter, genderFilter: $genderFilter)
                .presentationDetents([.medium])
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
