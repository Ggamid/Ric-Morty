//
//  DetailView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import SwiftUI

struct DetailView: View {
    
    let character: Character
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: character.image)){ image in
                    image.resizable()
                        .scaledToFill()
                        .clipShape(.rect(cornerRadius: 20))
                        .padding()
                } placeholder: {
                    
                    ProgressView()
                        .frame(height: 300)
                }

                
                Text(character.status)
                    .fontWeight(.bold)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(character.statusColor)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding(.horizontal)
                    .padding(.top, -14)
                
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text("Species: ").fontWeight(.bold) + Text(character.species)
                        Text("Gender: ").fontWeight(.bold) + Text(character.gender)
                        Text("Episodes: ").fontWeight(.bold) + Text(character.displayingEpisodes.formatted(.list(type: .and)))
                        Text("Last known location: ").fontWeight(.bold) + Text(character.location.name)
                        
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }
            .navigationTitle(character.name)
            .background(Color.grayCustom)
            .clipShape(.rect(cornerRadius: 20))
            .padding(.horizontal)
            
            Spacer()
        }
        
    }
}

#Preview {
    DetailView(character: .example)
}
