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
    @Published var notifications: Bool = UserDefaults.standard.bool(forKey: Preferences.notifications)
    @Published var themes: Bool = UserDefaults.standard.bool(forKey: Preferences.themes)
    @Published var biometrics: Bool = UserDefaults.standard.bool(forKey: Preferences.biometrics)
    let logOutSuccessSubject = PassthroughSubject<Void, Never>()
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Init -
    init(dataManager: SettingsDataManagerProtocol = SettingsDataManager(), secure: KeychainProvider = KeyChainData()) {
        self.dataManager = dataManager
        self.secure = secure
    }

    // MARK: Public Methods
    func logOut() {
        logOutByAPI()
        KeyChainData().deleteStringKey(key: KeyChainEnum.user)
        KeyChainData().deleteStringKey(key: KeyChainEnum.password)
        UserDefaults.standard.set(false,
                                  forKey: Preferences.rememberLogin)
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
        logOutSuccessSubject.send()
    }

    func notificationIsOn(_ bool: Bool) {
        UserDefaults.standard.setValue(bool,
                                       forKey: Preferences.notifications)
        self.activateNotifications(notifications: bool)
    }

    func themesIsOn(_ bool: Bool) {
        UserDefaults.standard.setValue(bool,
                                       forKey: Preferences.themes)
        self.toggleDarkMode(bool)
    }

    func biometricsIsOn(_ bool: Bool) {
        UserDefaults.standard.setValue(bool,
                                       forKey: Preferences.biometrics)
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
        
        isEnabled ? UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
        : UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
    }
}
