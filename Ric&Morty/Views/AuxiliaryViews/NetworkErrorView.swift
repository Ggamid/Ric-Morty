//
//  NetworkErrorView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 19.07.2024.
//

import SwiftUI

struct NetworkErrorView: View {
    
    var task: () -> ()
    
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            VStack{
                Image(.networkErrorRick)
                Text("Network Error")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                Text("There was an error connecting. Please check your internet.")
                    .multilineTextAlignment(.center)
                    .frame(width: 300)

            }
        }
        .preferredColorScheme(.dark)
        
    }
    
    init(task: @escaping () -> Void) {
        self.task = task
    }
}

#Preview {
    NetworkErrorView(task: {})
}
