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
    @Published var profileCreated = false
    
    @AppStorage(Preferences.nickname.rawValue) var userNickname = ""
    @AppStorage(Preferences.avatar.rawValue) var userAvatar = ""
    @AppStorage(Preferences.id.rawValue) var userId = ""
    
    // MARK: - Init -
    init(dataManager: ProfileDataManagerProtocol = ProfileDataManager(), passwordValidator: PasswordValidator = .init()) {
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
            Task {
                await showErrorMessage(error)
            }
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
        Task { @MainActor in
            showError.toggle()
            if let error = error as? PasswordValidator.PasswordError {
                errorMessage = error.description
            } else {
                errorMessage = "There has been a error"
            }
        }
    }
    
    func validateTextFields() -> Bool {
        !userText.textIsEmpty() &&
           !nicknameText.textIsEmpty() &&
           !passwordText.textIsEmpty() &&
           !confirmPasswordText.textIsEmpty()
            && passwordText == confirmPasswordText
    }
    
    func prepareProfile() throws -> [String:Any]? {
        if validateTextFields() {
          //  let avatar = UIImage(from: profileImage, size: 100)?.jpegData(compressionQuality: 1.0)?.base64EncodedString() ?? ""
            var token:String {
                UUID().uuidString
            }
            
            let passwordHash = try HashKit.shared.sha256(value:passwordText)
           return  ["email": userText,
             "password": passwordHash, //Hash
             "nickname": nicknameText,
             "avatar": "https://robohash.org/\(token)",
              "token": token, //Añadir token
             "platform": "iOS",
             "onLine":false
            ]
        } else {
            showError.toggle()
            errorMessage = "Can't be empty textfields"
        }
        return nil
    }
    
    func createProfile() {
        Task {
            do {
                guard let params = try prepareProfile() else { return }
                try await sendRegister(params: params)
            } catch {
                showErrorMessage(error)
            }
        }
    }
    
    func sendRegister(params: [String: Any]) async throws {
        let register =  try await dataManager.createAndRegisterProfile(params: params)
        if register.success {
            userId = register.id
            userAvatar = register.avatar
            userNickname = register.nickname
            profileCreated = true
            
        }
    }
    
    func clearFields() {
        userText = ""
        passwordText = ""
        confirmPasswordText = ""
        userAvatar = ""
        isValidPassword = false
        profileCreated = false
        profileImage = nil
        
    }
}
