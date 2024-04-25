//
//  ProfileViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import UIKit
import Combine

final class ProfileViewModel {
    // MARK: - Properties -
    private var dataManager: ProfileDataManager
    private var imageProfile: UIImage?
    var cancellables: Set<AnyCancellable> = []
    let navigateToHomeView = PassthroughSubject<Void, Never>()
    let emptyField = PassthroughSubject<Void, Never>()

    // MARK: - Init -
    init(dataManager: ProfileDataManager) {
        self.dataManager = dataManager
    }

    // MARK: Public Methods
    func addImage(image: UIImage) {
        imageProfile = image
    }

    func getImage() -> UIImage? {
        imageProfile
    }

    func comprobeText(user: String, nick: String, password: String, repeatPassword: String) {
        if !user.textIsEmpty(),
            !nick.textIsEmpty(),
           !password.textIsEmpty(),
           !repeatPassword.textIsEmpty() && password == repeatPassword {
            let params = ["login": user,
                          "password": password,
                          "nick": nick,
                          "platform": "ios",
                          "firebaseToken": "NoTokenNow"]
            createAndRegister(params: params)
        } else {
            emptyField.send()
        }
    }
}

private extension ProfileViewModel {
    func createAndRegister(params: [String: Any]) {
        dataManager.createAndRegisterProfile(params: params)
            .sink { completion in
                if case .failure(let error) = completion {
                  // print Error
                }
            } receiveValue: { [weak self] register in
                UserDefaults.standard.removeObject(forKey: Preferences.token)
                UserDefaults.standard.set(register.user.token,
                                          forKey: Preferences.token)
                UserDefaults.standard.removeObject(forKey: Preferences.id)
                UserDefaults.standard.set(register.user.id,
                                          forKey: Preferences.id)
                self?.navigateToHomeView.send()
            }.store(in: &cancellables)
    }
}
