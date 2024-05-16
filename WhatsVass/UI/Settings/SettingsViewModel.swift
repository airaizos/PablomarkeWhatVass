//
//  SettingsViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import Combine
import UserNotifications
import UIKit

final class SettingsViewModel: ObservableObject {
    // MARK: - Properties -
    private var dataManager: SettingsDataManagerProtocol
    private var secure: KeychainProvider
    private var persistence: LocalPersistence
    @Published var notifications: Bool = LocalPersistence.shared.getBool(forKey: .notifications)
    @Published var themes: Bool = LocalPersistence.shared.getBool(forKey: Preferences.themes)
    @Published var biometrics: Bool = LocalPersistence.shared.getBool(forKey: Preferences.biometrics)
    let logOutSuccessSubject = PassthroughSubject<Void, Never>()
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Init -
    init(dataManager: SettingsDataManagerProtocol = SettingsDataManager(), secure: KeychainProvider = KeyChainData(), persistence: LocalPersistence = .shared) {
        self.dataManager = dataManager
        self.secure = secure
        self.persistence = persistence
    }

    // MARK: Public Methods
    func logOut() {
        logOutByAPI()
        KeyChainData().deleteStringKey(key: KeyChainEnum.user)
        KeyChainData().deleteStringKey(key: KeyChainEnum.password)
        persistence.setObject(value: false, forKey: .rememberLogin)
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            persistence.removePersistenceDomain(forName: bundleIdentifier)
        }
        logOutSuccessSubject.send()
    }

    func notificationIsOn(_ bool: Bool) {
        persistence.setObject(value: bool, forKey: .notifications)
        self.activateNotifications(notifications: bool)
    }

    func themesIsOn(_ bool: Bool) {
        persistence.setObject(value: bool, forKey: .themes)
        self.toggleDarkMode(bool)
    }

    func biometricsIsOn(_ bool: Bool) {
        persistence.setObject(value: bool, forKey: .biometrics)
    }
}

private extension SettingsViewModel {
    func logOutByAPI() {
        dataManager.logOut()
            .sink { completion in
                if case .failure = completion {
                    
                }
            } receiveValue: { offline in

            }.store(in: &cancellables)
    }

    func activateNotifications(notifications: Bool) {
        if notifications {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                } else {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,
                                                                                      .badge]
                    ) { granted, error in
                        granted ? print(granted) : print("\(error?.localizedDescription ?? "")")
                    }
                }
            }
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }

    func toggleDarkMode(_ isEnabled: Bool) {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
          
            windows.forEach { window in
                window.overrideUserInterfaceStyle = isEnabled ? .dark : .light
                
            }
        }
        
//        isEnabled ? UIApplication.shared.windows.forEach { window in
//            window.overrideUserInterfaceStyle = .dark
//        }
//        : UIApplication.shared.windows.forEach { window in
//            window.overrideUserInterfaceStyle = .light
//        }
    }
}
