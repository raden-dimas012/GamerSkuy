//
//  EditProfileView.swift
//  GamerSkuy
//
//  Created by Raden Dimas on 29/09/22.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @Environment(\.self) private var env
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = Theme.isNotDarkMode
    var body: some View {
        VStack(spacing: 12) {
            createHeaderView()
            createContentView()
            createSecondContentView()
            createButtonSave()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay {
            ZStack {
                if viewModel.showDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.showDatePicker = false
                        }
                    DatePicker("", selection: $viewModel.textBirth)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(
                            cornerSize: .init(width: 12, height: 12),
                            style: .continuous))
                        .padding()
                }
            }
            .animation(.easeInOut, value: viewModel.showDatePicker)
        }
    }
    @ViewBuilder
    private func createHeaderView() -> some View {
        Text("Edit Profile")
            .font(.title3.bold())
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Button {
                    env.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(darkModeEnabled ? .white : .black)
                }
            }
    }
    @ViewBuilder
    private func createContentView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Name")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("", text: $viewModel.textName)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
        }
        .padding(.top, 10)
        Divider()
        VStack(alignment: .leading, spacing: 12) {
            Text("Birth Day")
                .font(.caption)
                .foregroundColor(.gray)
            Text(viewModel.textBirth.formatted(
                date: .abbreviated, time: .omitted))
            .font(.callout)
            .fontWeight(.semibold)
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.showDatePicker.toggle()
            } label: {
                Image(systemName: "calendar")
                    .foregroundColor(darkModeEnabled ? .white : .black)
            }
        }
        Divider()
    }
    @ViewBuilder
    private func createSecondContentView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Email")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("", text: $viewModel.textEmail)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
        }
        .padding(.top, 10)
        Divider()
        VStack(alignment: .leading, spacing: 12) {
            Text("Role")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("", text: $viewModel.textRole)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
        }
        .padding(.top, 10)
        Divider()
    }
    @ViewBuilder
    private func createButtonSave() -> some View {
        Button {
            if viewModel.textName.isEmpty ||
                viewModel.textEmail.isEmpty ||
                viewModel.textRole.isEmpty ||
                viewModel.validateEmail(email: viewModel.textEmail) {
                viewModel.showAlert = true
            } else {
                viewModel.saveDataProfile(
                    name: viewModel.textName,
                    birth: viewModel.textBirth.getFormattedDate(),
                    email: viewModel.textEmail,
                    role: viewModel.textRole
                )
                viewModel.showAlert = false
                viewModel.showDatePicker = false
                env.dismiss()
            }
        } label: {
            Text("Save Data")
                .font(.callout)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .foregroundColor(darkModeEnabled ? .black : .white)
                .background {
                    Capsule()
                        .fill(darkModeEnabled ? .gray : .black)
                }
        }
        .padding(.top, 15)
        .alert(isPresented: $viewModel.showAlert) {
            createAlert()
        }
    }
    private func createAlert() -> Alert {
        return Alert(
            title: Text("Something Went Wrong"),
            message: Text("Please Fill All The Texfields & Make Sure Your Email Is Valid."),
            dismissButton: .cancel()
        )
    }
}
