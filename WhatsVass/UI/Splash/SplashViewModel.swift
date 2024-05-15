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
    let persistence: LocalPersistence
    init(persistence: LocalPersistence = .shared) {
        self.persistence = persistence
    }
    // MARK: Public Methods
    func initPreferences() {
        if !persistence.getBool(forKey: Preferences.rememberLogin) {
            persistence.setObject(value: false, forKey: .rememberLogin)
        }
    }
}

