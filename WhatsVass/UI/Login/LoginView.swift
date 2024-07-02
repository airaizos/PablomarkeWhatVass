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
    @Environment(\.theme) private var theme: Theme
    @ObservedObject var viewModel =  LoginViewModel()
    @FocusState var namefields: Namefields?
    @State var showAlertBiometrics = false
    @State var showAlertEmtpy = false
    @Binding var navState: NavState
    var body: some View {
        VStack(spacing: 30) {
            LogoVassView()
            Spacer()
            VStack(spacing: 30) {
    
                VassTextField(text: viewModel.username) {
                    TextField(LocalizedStringKey("User"), text: $viewModel.username)
                        .keyboardType(.alphabet)
                        .autocorrectionDisabled()
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .focused($namefields, equals: .user)
                        .onSubmit {
                            namefields = .password
                        }
                }
                
                VassTextField(systemImage:"key", text: viewModel.password) {
                    SecureField(LocalizedStringKey("Password"), text: $viewModel.password)
                        .focused($namefields, equals: .password)
                        .submitLabel(.join)
                        .onSubmit {
                            viewModel.loginTapped()
                        }
                }
            }
            .font(.title3)
            .textFieldStyle(.roundedBorder)
            
            LabeledContent {
                VassToggle(isOn: $viewModel.rememberLogin,size: 50) {
                    viewModel.securingCredentials()
                }
            } label: {
                Text(LocalizedStringKey("Remember"))
                    .foregroundStyle(.white)
                    .font(.subheadline)
            }
            .frame(width: 150)
            
            VassButton(title: "Login") {
               viewModel.loginTapped()
                //FIX: navega solo si autoriza
                 //   navState = .home
                        }
            Spacer()
            Button(LocalizedStringKey("Sign in")) {
                navState = .register
            }
            .foregroundStyle(.white)
            
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                
            }
            
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
                viewModel.initData()
                // Tiene que devolver un valor, sino no se utilzian los nameFields
                
                namefields = .user
            }
            .onChange(of: viewModel.isLogged) { oldValue, newValue in
                if newValue {
                    navState = .home
                }
            }
        }
        .padding()
        .vassBackground(theme)
        .onTapGesture {
            hideKeyboard()
        }
    }
    }

#Preview {
    LoginView(navState: .constant(.register))
}


