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
    var passwordValidator = PasswordValidator()
    @State var userText: String = ""
    @State var nicknameText: String = ""
    @State var passwordText: String = ""
    @State var confirmPasswordText: String = ""
    @State var isValidPassword: Bool?
    @State var errorMessage: String = ""
    @State var showError = false
    @FocusState var nameFields: NameFields?
    var delegate: ProfileViewDelegate?
    var body: some View {
        VStack(spacing:20) {
            ProfileImageView()
                .padding()
            VassTextField(text: userText) {
                TextField(LocalizedStringKey("User"), text: $userText)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($nameFields, equals: .user)
                    .onSubmit {
                        nameFields = .nickname
                    }
            }
            VassTextField(systemImage: "sunglasses",text: nicknameText) {
                TextField(LocalizedStringKey("Nick"), text: $nicknameText)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($nameFields, equals: .nickname)
                    .onSubmit {
                        nameFields = .password
                    }
            }
            VassTextField(systemImage: "key", text: passwordText) {
                SecureField(LocalizedStringKey("Password"), text: $passwordText)
                    .focused($nameFields, equals: .password)
                    .submitLabel(.join)
                    .onSubmit {
                        Task {
                            //TODO: Pasar al viewModel
                            do {
                                try passwordValidator.isStrongPassword(passwordText)
                            } catch let error {
                                if let passwordError = error as? PasswordValidator.PasswordError {
                                    errorMessage = passwordError.description
                                    showError.toggle()
                                }
                            }
                        }
                    }
            }
            if isValidPassword == false {
                Text("*" + errorMessage)
                    .foregroundStyle(.red)
                    .font(.subheadline)
            }
            
            VassTextField(systemImage:"key.horizontal", text: confirmPasswordText) {
                SecureField(LocalizedStringKey("RepeatPassword"), text: $confirmPasswordText)
                    .focused($nameFields, equals: .confirmPassword)
                    .submitLabel(.join)
                    .onSubmit {
                        if passwordText != confirmPasswordText || confirmPasswordText.isEmpty {
                            errorMessage = "Password do not match"
                            showError.toggle()
                        }
                    }
            }
            Spacer()
            VassButton(title: "Sign in") {
                // validar que el user y el nickname no existan ya
                
                //validar que el pasword sea seguro
                //validar que coincida el password y el confirm
                delegate?.createProfile(user: userText, nick: nicknameText, password: passwordText, confirmPassword: confirmPasswordText)
            }
            
        }
        .font(.title3)
        .textFieldStyle(.roundedBorder)
        .padding()
        .vassBackground()
        
        .onAppear {
            nameFields = .user
        }
        
        .alert(errorMessage, isPresented: $showError) {
            Button("OK") {
                passwordText = ""
                nameFields = .password
                showError.toggle()
            }
        }
    }
}

#Preview {
    ProfileView(userText: "", nicknameText: "", passwordText: "", confirmPasswordText: "")
}

struct ProfileImageView: View {
    @State var photItem: PhotosPickerItem?
    @State var profileImage: Image?
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

extension PhotosPickerItem {
    @MainActor
    func convert() async -> Image {
        do {
            if let data = try await self.loadTransferable(type: Data.self) {
                if let uiimage = UIImage(data: data), let resizedUuimage = uiimage.resizeImage(250) {
                    return Image(uiImage: resizedUuimage)
                }
            }
        } catch {
            //no se ha podido cargar la imagen
            return Image(systemName: "person.crop.circle")
        }
        return Image(systemName: "person.crop.circle")
    }
}
