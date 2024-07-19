//
//  NothinFoundView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 18.07.2024.
//

import SwiftUI

struct NothinFoundView: View {
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Text("No matches found")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .bold()
                        Text("Please try another filters")
                            .foregroundStyle(Color.gray)
                            .font(.caption)
                    }
                    .padding(.trailing)
                }
                .frame(height: 110)
                .frame(maxWidth: .infinity)
                .background(Color.grayCustom)
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal, 5)
            }
            .frame(height: 260)
            
            
            
            HStack{
                Image(.rickAndMortyNothingFound41)
                Spacer()
            }
            
        }
        .frame(height: 300)
    }
}

#Preview {
    NothinFoundView()
}
