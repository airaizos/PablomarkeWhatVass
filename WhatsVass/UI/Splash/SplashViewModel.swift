//
//  SplashViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import Foundation
import Combine

final class SplashViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var isLoading = false

    // MARK: Public Methods
    func initPreferences() {
        if !UserDefaults.standard.bool(forKey: Preferences.rememberLogin) {
            UserDefaults.standard.set(false,
                                      forKey: Preferences.rememberLogin)
        }
    }
}

