//
//  ProfileView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 11/09/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = Theme.isNotDarkMode
    var body: some View {
        ScrollView {
            createImageView()
            createProfileView()
            createButtonEditProfile()
        }
        .fullScreenCover(isPresented: $viewModel.isPresented, content: {
            EditProfileView()
                .environmentObject(viewModel)
        })
        .onAppear {
            viewModel.getDataFromUserDefaults()
        }
    }
    @ViewBuilder
    private func createImageView() -> some View {
        Image(viewModel.profile?.image ?? "MyPhoto")
            .resizable()
            .frame(width: 170, height: 170)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 5)
            .padding()
    }
    @ViewBuilder
    private func createProfileView() -> some View {
        VStack {
            createContentProfile(
                headerText: viewModel.constant?.name ?? "",
                imageName: viewModel.constant?.imageName ?? "",
                profileText: viewModel.profile?.name ?? ""
            )
            createContentProfile(
                headerText: viewModel.constant?.birth ?? "",
                imageName: viewModel.constant?.imageBirth ?? "",
                profileText: viewModel.profile?.birth ?? ""
            )
            createContentProfile(
                headerText: viewModel.constant?.email ?? "",
                imageName: viewModel.constant?.imageEmail ?? "",
                profileText: viewModel.profile?.email ?? ""
            )
            createContentProfile(
                headerText: viewModel.constant?.role ?? "",
                imageName: viewModel.constant?.imageRole ?? "",
                profileText: viewModel.profile?.role ?? ""
            )
        }
        .frame(maxWidth: .infinity)
    }
    @ViewBuilder
    private func createButtonEditProfile() -> some View {
        Button {
            viewModel.isPresented = true
        } label: {
            Label {
                Text("Edit Profile")
            } icon: {
                Image(systemName: "pencil")
            }
            .foregroundColor(darkModeEnabled ? .black : .white)
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(darkModeEnabled ? .gray : .black, in: Capsule())
        }
        .frame(maxWidth: .infinity)
    }
    @ViewBuilder
    private func createContentProfile(headerText: String, imageName: String, profileText: String) -> some View {
        Section(header: Text(headerText).font(.title)) {
            HStack {
                Image(systemName: imageName)
                    .font(.title)
                Text(profileText)
                    .font(.title2)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}
