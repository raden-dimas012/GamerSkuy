//
//  SearchBarView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 12/09/22.
//

import SwiftUI

struct SearchBarView: View {
    @State var searchText: String = ""
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText)
                .onChange(of: searchText, perform: { newValue in
                    viewModel.querySearch = newValue
                    viewModel.getFilteredGame(query: newValue)
                })
                .onSubmit {
                    withAnimation {
                        viewModel.querySearch = searchText
                        viewModel.getFilteredGame(query: searchText)
                    }
                }
            }
            .foregroundColor(.white)
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}
