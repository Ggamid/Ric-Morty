//
//  LoadingView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 19.07.2024.
//

import SwiftUI

struct LoadingView: View {
    
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var scale = 0.7
    
    var body: some View {
        ZStack{
            Image(.rickAndMortyBackground1)
                .ignoresSafeArea()
            Image(.rickMortyLoadingView)
                .scaleEffect(scale)
                .animation(.bouncy(duration: 1), value: scale)
        }
        .onAppear{
            withAnimation(.bouncy) {
                scale+=0.6
            } completion: {
                withAnimation {
                    scale = 1
                }
            }
        }
    }
}

#Preview {
    LoadingView()
}
