//
//  CharacterView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import SwiftUI
import SwiftData

struct CharacterRow: View {
    
    let character: Character
    @Query var favoritesList: [Favorites]
    @Environment(\.modelContext) var modelContext
    var isFavorite: Bool {
        Favorites.isContained(id: character.id, list: favoritesList)
    }
    
    var body: some View {
        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 140)
                    .foregroundStyle(Color.grayCustom)

                HStack{
                    
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 100)
                            .clipShape(.rect(cornerRadius: 20))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 140)
                    }
                    .padding(.leading)
                    .padding(.trailing, 5)
                    
                    VStack (alignment: .leading, spacing: 10){
                        Text("\(character.name)")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.top)
                            .truncationMode(.tail)
                        
                        HStack(){
                            Text(character.status)
                                .foregroundStyle(character.statusColor)
                                .fontWeight(.bold)
                            
                            +
                            Text(" • ")
                                .foregroundStyle(.white)
                            +
                            Text(character.species)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                            
                        
                        Text(character.gender)
                            .foregroundStyle(.white)
                        Spacer()
                        
                    }
                    Spacer()

                }
                .frame(height: 100)
                
                
            }
            .overlay{
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundStyle(.cyan)
                            .padding()
                            .onTapGesture {
                                if !isFavorite {
                                    modelContext.insert(Favorites(id: character.id))
                                } else {
                                    let fav = Favorites.findFav(id: character.id, list: favoritesList)
                                    if fav != -1 {
                                        modelContext.delete(favoritesList[fav])
                                    }
                                }
                            }
                    }
                }
            }
        }
        .frame(height: 150)
    }
    

}

#Preview {
    CharacterRow(character: .example)
}


extension Color {
    static let grayCustom = Color(#colorLiteral(red: 0.08342342824, green: 0.08361873776, blue: 0.08949685842, alpha: 1))
    static let greenCustom = Color(#colorLiteral(red: 0.1007835194, green: 0.5291658044, blue: 0.2169768214, alpha: 1))
    static let redCustom = Color(#colorLiteral(red: 0.8400415182, green: 0.1365679801, blue: 0.0008404203691, alpha: 1))
    
}
