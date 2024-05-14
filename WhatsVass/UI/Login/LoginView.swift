//
//  LoginView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 13/5/24.
//

import SwiftUI

extension LoginView {
    enum Namefields {
        case user, password
    }
}

struct LoginView: View {
    //  @EnvironmentObject var viewModel = LoginViewModel()
    @State var userText = ""
    @State var passwordText  = ""
    @State var remember = false
    @FocusState var namefields: Namefields?
    var delegate: LoginViewDelegate?
    @State var showAlertBiometrics = false
    @State var showAlertEmtpy = false
    
    var body: some View {
        VStack(spacing: 30) {
            LogoVassView()
            Spacer()
            VStack(spacing: 30) {
                VassTextField(text: userText) {
                    TextField(LocalizedStringKey("User"), text: $userText)
                        .keyboardType(.alphabet)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .focused($namefields, equals: .user)
                        .onSubmit {
                            namefields = .password
                            delegate?.loginUser(userText)
                        }
                }
                
                VassTextField(systemImage:"key", text: passwordText) {
                    SecureField(LocalizedStringKey("Password"), text: $passwordText)
                        .focused($namefields, equals: .password)
                        .submitLabel(.join)
                        .onSubmit {
                            if !userText.isEmpty && !passwordText.isEmpty {
                                showAlertEmtpy.toggle()
                            } else {
                                delegate?.loginPassword(passwordText)
                                delegate?.loginTapped(remember: remember)
                            }
                        }
                }
            }
            
            .font(.title3)
            .textFieldStyle(.roundedBorder)
          
            LabeledContent {
                VassToggle(isOn: $remember,size: 50) {
                    delegate?.rememberUserAndPassword(remember)
                }
            } label: {
                Text(LocalizedStringKey("Remember"))
                    .foregroundStyle(.white)
                    .font(.subheadline)
            }
            .frame(width: 150)
            
            VassButton(title: "Login") {
                if userText.isEmpty {
                    namefields = .user
                    showAlertEmtpy.toggle()
                } else if passwordText.isEmpty {
                    namefields = .password
                    showAlertEmtpy.toggle()
                } else {
                    delegate?.loginUser(userText)
                    delegate?.loginPassword(passwordText)
                    delegate?.loginTapped(remember: remember)
                }
            }
            Spacer()
            Button(LocalizedStringKey("Create Profile")) {
                delegate?.navigateToProfileView()
            }
            .foregroundStyle(.white)
            
            .alert(LocalizedStringKey("Biometrics"), isPresented: $showAlertBiometrics) {
                
            } message: {
                Text(LocalizedStringKey("EnterBiometrics"))
            }
            .alert(LocalizedStringKey("Login Error"), isPresented: $showAlertEmtpy) {
                Button(LocalizedStringKey("OK")) {
                    showAlertEmtpy.toggle()
                }
            } message: {
                Text(LocalizedStringKey("Incorrect username or password"))
            }
            .onAppear {
                namefields = .user
                delegate?.initView()
            }
        }
        .padding()
        .vassBackground()
    }
}

#Preview {
    LoginView()
}


