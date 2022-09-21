//
//  ProfileView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    var body: some View {
        VStack {
            Image(viewModel.profile.image)
                .resizable()
                .frame(width: 170, height: 170)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 5)
                .padding()
            Form {
                Section(header: Text(viewModel.constant?.name ?? "")) {
                    HStack {
                        Image(systemName: viewModel.constant?.imageName ?? "")
                        Text(viewModel.profile.name)
                    }
                }
                Section(header: Text(viewModel.constant?.birth ?? "")) {
                    HStack {
                        Image(systemName: viewModel.constant?.imageBirth ?? "")
                        Text(viewModel.profile.birth)
                    }
                }
                Section(header: Text(viewModel.constant?.email ?? "")) {
                    HStack {
                        Image(systemName: viewModel.constant?.imageEmail ?? "")
                        Text(viewModel.profile.email)
                    }
                }
                Section(header: Text(viewModel.constant?.role ?? "")) {
                    HStack {
                        Image(systemName: viewModel.constant?.imageRole ?? "")
                        Text(viewModel.profile.role)
                    }
                }
            }
        }
    }
}
