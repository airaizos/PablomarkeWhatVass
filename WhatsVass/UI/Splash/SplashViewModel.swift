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
    
    func navigateToLogin() {
        NotificationCenter.default.post(name: .splash, object: nil)
    }
}

