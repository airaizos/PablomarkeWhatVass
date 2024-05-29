//
//  LoginViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import SwiftUI

final class LoginViewModel: ObservableObject, ErrorHandling {
    // MARK: - Properties -
    private var dataManager: LoginDataManagerProtocol
    private var secure: KeychainProvider
    private var biometrics: BiometricAuthentication
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isLogged = false
    
    @AppStorage(Preferences.rememberLogin.rawValue) var loginExist = false
    @AppStorage(Preferences.rememberLogin.rawValue) var rememberLogin = false
    @AppStorage(Preferences.biometrics.rawValue) var isBiometricOn = false
    
    
    // MARK: - Init -
    init(dataManager: LoginDataManagerProtocol = LoginDataManager(), secure: KeychainProvider = KeyChainData(),  biometrics: BiometricAuthentication = BiometricAuthentication()) {
        self.dataManager = dataManager
        self.secure = secure
        self.biometrics = biometrics
    }
    
    //MARK: - View Methods -
    @MainActor
    func initData() {
        comprobeTokenAndBiometrics()
        comprobeRememberLogin()
    }
    
    
    func loginTapped() {
        securingCredentials()
        requestLogin()
    }
    
    func securingCredentials() {
        if rememberLogin {
            secure.setUserAndPassword(username,password)
        } else {
            secure.deleteUserAndPasword(username,password)
        }
    }
    
   
    func requestLogin() {
        guard !isUserAndPasswordEmpty() else { return  }
        let credentials = ["password": password,
                           "login": username,
                           "platform": "ios",
                           "firebaseToken": "fgjñdjsfgdfj"]
        Task {
            await requestAccess(credentials: credentials)
        }
    }
    
 
}

//MARK: - Private methods -
private extension LoginViewModel {
    func isUserAndPasswordEmpty() -> Bool {
        if username.isEmpty {
            showErrorMessage(BaseError.userEmpty)
            return true
        } else if password.isEmpty {
            showErrorMessage(BaseError.passwordEmpty)
            return true
        }
        return false
    }
    
    func comprobeTokenAndBiometrics()  {
        if isBiometricOn {
            getBiometric()
        }
    }
    
    func comprobeRememberLogin() {
        if rememberLogin {
            loginExist = getUserAndPasswordFromSecure()
        }
    }
    
    func getBiometric() {
        biometrics.authenticationWithBiometric {
            self.loginWithBiometricUserCredentials()
        } onFailure: { error in
            self.showErrorMessage(error)
        }
    }
    
    
    func getUserAndPasswordFromSecure() -> Bool {
        let keys = secure.getUserAndPassword()
        guard let userKey = keys.0, let passwordKey = keys.1 else {
            return false
        }
        username = userKey
        password = passwordKey
        return true
    }
    
   
    
    func loginWithBiometrics() {
        loginWithBiometricUserCredentials()
    }
    
    //MARK: Async await
    
    //FIXME: tiene que devolver un Bool
    private func requestAccess(credentials: [String: Any]) async {
        do {
            let _ = try await dataManager.login(with: credentials)
 // si devuelve token y usarioo entra
            isLogged = true
        } catch {
            showErrorMessage(error)
        }
    }
    
    //FIXME: tiene que devolver un Bool
    private func loginWithBiometricUserCredentials()  {
        guard let token = secure.getToken() else {
            showErrorMessage(BaseError.noToken)
            return
        }
        
        let params = ["Authorization": token]
        Task {
            do {
                let _ = try await dataManager.loginWithBiometric(params: params)
              //  NotificationCenter.default.post(name: .login, object: nil)
                isLogged = true
            } catch {
                showErrorMessage(error)
            }
        }
    }
}
