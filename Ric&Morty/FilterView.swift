//
//  FilterView.swift
//  Ric&Morty
//
//  Created by Gamıd Khalıdov on 17.07.2024.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var statusFilter: Status
    @Binding var genderFilter: Gender
    
    @State private var temporaryStatus: Status = .none
    @State private var temporaryGender: Gender = .none
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .center){
                Image(systemName: "multiply")
                    .font(.largeTitle)
                    .padding(.leading)
                Spacer()
                Text("Filters")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                
                Button{
                    statusFilter = .none
                    genderFilter = .none
                    dismiss()
                } label: {
                    Text("Reset")
                        .font(.title2)
                        .padding(.trailing)
                }
                .foregroundStyle(.white)
                
                
            }
            Text("Status")
                .padding()
                .fontWeight(.medium)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(Status.allCases, id: \.self){ status in
                        Button{
                            temporaryStatus = status
                        }label: {
                            HStack{
                                Text(status.rawValue)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                
                                if status == temporaryStatus {
                                    Image(systemName: "checkmark")
                                        .padding(.trailing)
                                }
                            }
                            .foregroundStyle(temporaryStatus == status ? .black : .white)
                            .background(temporaryStatus == status ? .white : .clear)
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(temporaryStatus == status ? .white : .gray, lineWidth: 2)
                            }
                        }
                        .padding(.vertical, 5)
                        .foregroundStyle(.white)
                    }
                }
            }
            .padding(.leading)
            
            Text("Gender")
                .padding()
                .fontWeight(.medium)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(Gender.allCases, id: \.self){ gender in
                        Button{
                            temporaryGender = gender
                        }label: {
                            HStack{
                                Text(gender.rawValue)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                
                                if gender == temporaryGender {
                                    Image(systemName: "checkmark")
                                        .padding(.trailing)
                                }
                            }
                            .foregroundStyle(temporaryGender == gender ? .black : .white)
                            .background(temporaryGender == gender ? .white : .clear)
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(temporaryGender == gender ? .white : .gray, lineWidth: 2)
                            }
                        }
                        .padding(.vertical, 5)
                        .foregroundStyle(.white)
                            
                    }
                }
            }
            .padding(.leading)
            
            Button{
                statusFilter = temporaryStatus
                genderFilter = temporaryGender
                dismiss()
            } label: {
                Text("Apply")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 40)
                    .background(.cyan)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    .bold()
            }
            .padding()
            
        }.preferredColorScheme(.dark)
            .onAppear{
                temporaryGender = genderFilter
                temporaryStatus = statusFilter
            }
    }
    
}

#Preview {
    FilterView(statusFilter: .constant(.alive), genderFilter: .constant(.female))
}
