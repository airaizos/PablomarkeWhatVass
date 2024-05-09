//
//  SplashViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import Foundation
import Combine

final class SplashViewModel {
    // MARK: - Properties -
    var cancellables: Set<AnyCancellable> = []
    let loginExist = PassthroughSubject<Void, Never>()

    // MARK: Public Methods
    func initView() {
        initPreferences()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.loginExist.send()
        }
    }
}

private extension SplashViewModel {
    func initPreferences() {
        if !UserDefaults.standard.bool(forKey: Preferences.rememberLogin) {
            UserDefaults.standard.set(false,
                                      forKey: Preferences.rememberLogin)
        }
    }
}
