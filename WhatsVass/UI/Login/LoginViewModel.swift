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
    private var dataManager: LoginDataManagerProtocol
    private var secure: KeyChainData
    private var persistence: LocalPersistence
    @Published var username: String?
    @Published var password: String?
    @Published var loginExist: Bool?
    @Published var rememberLogin: Bool? {
        didSet {
            persistence.setObject(value: rememberLogin,forKey: .rememberLogin)
        }
    }
    let loginSuccessSubject = PassthroughSubject<Bool, Never>()
    let loginSuccessBiometrics = PassthroughSubject<Void, Never>()
    let loginFailureBiometrics = PassthroughSubject<Void, Never>()
    let loginFailureSubject = PassthroughSubject<String, Never>()
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Init
    init(dataManager: LoginDataManagerProtocol, secure: KeyChainData, persistence: LocalPersistence = .shared) {
        self.dataManager = dataManager
        self.secure = secure
        //TODO: Debería ir en el dataManager?
        self.persistence = persistence
        self.loginExist = persistence.getBool(forKey: .rememberLogin)
    }

    // MARK: - Public Methods
    func rememberLoginPreferences(_ remember: Bool) {
        persistence.setObject(value: remember,forKey: Preferences.rememberLogin)
    }
    
    func loginButtonWasTapped(remember: Bool) {
        rememberLoginPreferences(remember)
        comprobeUserAndPassword(remember: remember)
    }

    func initData() {
        comprobeTokenAndBiometrics()
        comprobeRememberLogin()
    }

    func comprobeTokenAndBiometrics() {
        if persistence.getBool(forKey: .biometrics) {
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

    func comprobeUserAndPassword(remember: Bool) {
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
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                
                if case let .failure(error) = completion {
                    
                    self?.loginFailureSubject.send(error.localizedDescription)
                    print("Error \(error)")
                }
            } receiveValue: { [weak self] login in
                
                self?.persistence.setObject(value: login.token, forKey: .token)
                self?.persistence.setObject(value: login.user.id, forKey: .id)
                if remember {
                    self?.secure.setLoginAndPassword(user: (self?.username) ?? "",
                                                     password: (self?.password) ?? "")
                    self?.persistence.setObject(value: remember, forKey: .rememberLogin)
                }
                self?.loginSuccessSubject.send(remember)
            }.store(in: &cancellables)
    }

    func loginWithBiometricUserCredentials() {
        guard let token = persistence.getString(forKey: Preferences.token) else {
            self.loginFailureSubject.send(BaseError.noToken.description())
            return
        }

        let params = ["Authorization": token]
        dataManager.loginWithBiometric(params: params)
            .sink { completion in
                if case .failure = completion {
               // print(error.description()
                }
            } receiveValue: { [weak self] login in
                self?.persistence.setObject(value: login.token, forKey: .token)
                self?.loginSuccessBiometrics.send()
            }.store(in: &cancellables)
    }
}
