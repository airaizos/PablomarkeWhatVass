//
//  ProfileViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties -
    private var dataManager: ProfileDataManagerProtocol
    private var imageProfile: UIImage?
    private var passwordValidator: PasswordValidator
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var userText: String = ""
    @Published var nicknameText: String = ""
    @Published var passwordText: String = ""
    @Published var confirmPasswordText: String = ""
    @Published var profileImage: Image?
    @Published var isValidPassword: Bool?
    
    // MARK: - Init -
    init(dataManager: ProfileDataManagerProtocol, passwordValidator: PasswordValidator = .init()) {
        self.dataManager = dataManager
        self.passwordValidator = passwordValidator
    }

    //MARK: - Public Methods -
    @discardableResult
    func isStrongPassword() -> Bool {
        do {
            return try passwordValidator.isStrongPassword(passwordText)
        } catch {
            showErrorMessage(error)
        }
        return false
    }
    
    @discardableResult
    func isPasswordConfirmed() -> Bool {
        if passwordText != confirmPasswordText || confirmPasswordText.isEmpty {
            errorMessage = "Password do not match"
            showError.toggle()
            return false
        } else {
            return true
        }
    }
    
    func errorMessageTapped() {
        showError.toggle()
    }
    
    func isValidUser() -> Bool {
        do {
            return try passwordValidator.isValid(userText)
        } catch {
            showErrorMessage(error)
        }
        return false
    }
    
    func isValidNickname() -> Bool {
        do {
            return try passwordValidator.isValid(nicknameText)
        } catch {
            showErrorMessage(error)
        }
        return false
    }
    
    
    
    func signInTapped() {
        if isValidUser()
            && isValidNickname()
            && isPasswordConfirmed()
            && isStrongPassword(){
            createProfile()
        }
    }
}

//MARK: - Private methods -
private extension ProfileViewModel {
    
    func showErrorMessage(_ error: Error) {
        showError.toggle()
        if let error = error as? PasswordValidator.PasswordError {
            errorMessage = error.description
        } else {
            errorMessage = "There has been a error"
        }
    }
    
    func validateTextFields() -> [String:Any]? {
        if !userText.textIsEmpty(),
           !nicknameText.textIsEmpty(),
           !passwordText.textIsEmpty(),
           !confirmPasswordText.textIsEmpty()
            && passwordText == confirmPasswordText {
            return ["login": userText,
                    "password": passwordText,
                    "nick": nicknameText,
                    "platform": "ios",
                    "firebaseToken": "NoTokenNow"]
        } else {
            showError.toggle()
            errorMessage = "Can't be empty textfields"
        }
        return nil
    }
    
    func createProfile() {
        guard let params = validateTextFields() else { return }
        Task {
            do {
                try await sendRegister(params: params)
            } catch {
                showErrorMessage(error)
            }
        }
    }
    
    func sendRegister(params: [String: Any]) async throws {
        let register =  try await dataManager.createAndRegisterProfile(params: params)
        LocalPersistence.shared.removeObject(forKey: .token)
        LocalPersistence.shared.setObject(value: register.user.token, forKey: .token)
        LocalPersistence.shared.removeObject(forKey: .id)
        LocalPersistence.shared.setObject(value: register.user.id, forKey: .id)
        
        NotificationCenter.default.post(name: .navigateToHomeView, object: nil)
    }
}
