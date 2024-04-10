//
//  LoginViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import Combine
import Foundation

final class LoginViewModel {
    // MARK: - Properties
    private var dataManager: LoginDataManager
    private var secure: KeyChainDataProvider
    @Published var username: String?
    @Published var password: String?
    @Published var loginExist: Bool?
    @Published var rememberLogin: Bool? = UserDefaults.standard.bool(forKey: Preferences.rememberLogin)
    let loginSuccessSubject = PassthroughSubject<Bool, Never>()
    let loginSuccessBiometrics = PassthroughSubject<Void, Never>()
    let loginFailureBiometrics = PassthroughSubject<Void, Never>()
    let loginFailureSubject = PassthroughSubject<String, Never>()
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Init
    init(dataManager: LoginDataManager, secure: KeyChainDataProvider) {
        self.dataManager = dataManager
        self.secure = secure
    }

    // MARK: - Public Methods
    func loginButtonWasTapped(remember: Bool) {
        UserDefaults.standard.setValue(remember,
                                       forKey: Preferences.rememberLogin)
        comprobeUserAndPassword(remember: remember)
    }

    func initData() {
        comprobeTokenAndBiometrics()
        comprobeRememberLogin()
    }

    func comprobeTokenAndBiometrics() {
        if UserDefaults.standard.bool(forKey: Preferences.biometrics) {
            getBiometric()
        }
    }

    func comprobeRememberLogin() {
        if rememberLogin ?? false {
            loginExist = comprobeLoginAndPassword()
        }
    }
}

private extension LoginViewModel {
    func getBiometric() {
        BiometricAuthentication().authenticationWithBiometric { [weak self] in
            self?.loginWithBiometricUserCredentials()
        } onFailure: { [weak self] error in
            print(error.localizedDescription)
            self?.loginFailureBiometrics.send()
        }
    }

    func comprobeLoginAndPassword() -> Bool {
        username = secure.getStringKey(key: KeyChainEnum.user)
        password = secure.getStringKey(key: KeyChainEnum.password)
        return ((username?.isEmpty) != nil)
    }

    func comprobeUserAndPassword(remember: Bool)  {
        guard let username = username, !username.isEmpty,
              let password = password, !password.isEmpty else {
            loginFailureSubject.send("EmptyLoginField")
            return
        }

        let credentials = ["password": password,
                           "login": username,
                           "platform": "ios",
                           "firebaseToken": "fgjñdjsfgdfj"]
        loginWithCredentials(remember: remember, credentials: credentials)
    }

    func loginWithCredentials(remember: Bool, credentials: [String: Any]) {
        dataManager.login(with: credentials)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.loginFailureSubject.send(error.localizedDescription)
                    print("Error \(error)")
                }
            } receiveValue: { [weak self] login in
                UserDefaults.standard.set(login.token,
                                          forKey: Preferences.token)
                UserDefaults.standard.set(login.user.id,
                                          forKey: Preferences.id)
                if remember {
                    self?.secure.setLoginAndPassword(user: (self?.username) ?? "",
                                                     password: (self?.password) ?? "")
                    UserDefaults.standard.setValue(remember,
                                                   forKey: Preferences.rememberLogin)
                }
                self?.loginSuccessSubject.send(remember)
            }.store(in: &cancellables)
    }

    func loginWithBiometricUserCredentials() {
        guard let token = UserDefaults.standard.string(forKey: Preferences.token) else {
            self.loginFailureSubject.send(BaseError.noToken.description())
            return
        }

        let params = ["Authorization": token]
        dataManager.loginWithBiometric(params: params)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print("Error \(error.description())")
                }
            } receiveValue: { [weak self] login in
                UserDefaults.standard.set(login.token,
                                          forKey: Preferences.token)
                self?.loginSuccessBiometrics.send()
            }.store(in: &cancellables)
    }
}
