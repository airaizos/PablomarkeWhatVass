//
//  ProfileView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 14/5/24.
//

import SwiftUI
import PhotosUI

extension ProfileView {
    enum NameFields {
        case user, nickname, password, confirmPassword
    }
}

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @FocusState var nameFields: NameFields?
    
    var body: some View {
        VStack(spacing:20) {
            ProfileImageView(profileImage: $viewModel.profileImage)
                .padding()
            VassTextField(text: viewModel.userText) {
                TextField(LocalizedStringKey("User"), text: $viewModel.userText)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($nameFields, equals: .user)
                    .onSubmit {
                        if viewModel.isValidUser() {
                            nameFields = .nickname
                        }
                    }
            }
          
            VassTextField(systemImage: "sunglasses",text: viewModel.nicknameText) {
                TextField(LocalizedStringKey("Nick"), text: $viewModel.nicknameText)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($nameFields, equals: .nickname)
                    .onSubmit {
                        if viewModel.isValidNickname() {
                            nameFields = .password
                        }
                    }
            }
            VassTextField(systemImage: "key", text: viewModel.passwordText) {
                SecureField(LocalizedStringKey("Password"), text: $viewModel.passwordText)
                    .focused($nameFields, equals: .password)
                    .submitLabel(.join)
                    .onSubmit {
                        if viewModel.isStrongPassword() {
                            nameFields = .confirmPassword
                        }
                    }
            }
            if viewModel.isValidPassword == false {
                Text("*" + viewModel.errorMessage)
                    .foregroundStyle(.red)
                    .font(.subheadline)
            }
            
            VassTextField(systemImage:"key.horizontal", text: viewModel.confirmPasswordText) {
                SecureField(LocalizedStringKey("RepeatPassword"), text: $viewModel.confirmPasswordText)
                    .focused($nameFields, equals: .confirmPassword)
                    .submitLabel(.join)
                    .onSubmit {
                        if viewModel.isPasswordConfirmed() {
                            viewModel.signInTapped()
                        }
                    }
            }
            Spacer()
            VassButton(title: "Sign in") {
                viewModel.signInTapped()
            }
        }
        .font(.title3)
        .textFieldStyle(.roundedBorder)
        .padding()
        .vassBackground()
        
        .onAppear {
            nameFields = .user
        }
        
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            Button("OK") {
                viewModel.errorMessageTapped()
            }
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(dataManager: ProfileDataManagerMock()))
}

struct ProfileImageView: View {
    @State var photItem: PhotosPickerItem?
    @Binding var profileImage: Image?
    var body: some View {
        ZStack(alignment:.bottomTrailing) {
            if let profileImage {
                Circle()
                    .stroke(.darkDarkmode,lineWidth: 3)
                    .shadow(color: .darkDarkmode,radius: 2, x: 1,y:1)
                    .background(
                        profileImage
                            .resizable()
                            .clipShape(Circle())
                    )
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.customWhite)
            }
            PhotosPicker(selection: $photItem, matching: .images) {
                Image(systemName: "camera.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 60)
                    .background(
                        Circle()
                            .foregroundStyle(.main)
                    )
                    .opacity(profileImage == nil ? 1 : 0.3)
            }
            
        }
        .frame(width: 250)
        .onChange(of: photItem) { _, newValue in
            if let newValue {
                Task {
                    profileImage = await newValue.convert()
                    // Guardar la imagen
                }
            }
        }
    }
}
