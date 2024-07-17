//
//  CharacterView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import SwiftUI

struct CharacterRow: View {
    
    let character: Character
    
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
                    }
                    .padding(.leading)
                    .padding(.trailing, 5)
                    
                    VStack (alignment: .leading, spacing: 10){
                        Text("\(character.name)")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.top)
                        
                        HStack(){
                            Text(character.status)
                                .foregroundStyle(character.status == "Alive" ? .green : .red)
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
        }
        .frame(height: 150)
    }
}

#Preview {
    CharacterRow(character: .example)
}


extension Color {
    static let grayCustom = Color(#colorLiteral(red: 0.08342342824, green: 0.08361873776, blue: 0.08949685842, alpha: 1))
}
