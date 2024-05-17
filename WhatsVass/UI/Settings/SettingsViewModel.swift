//
//  SettingsViewModel.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

//import Combine
import UserNotifications
import UIKit

final class SettingsViewModel: ObservableObject {
    // MARK: - Properties -
    private var dataManager: SettingsDataManagerProtocol
    private var secure: KeychainProvider
    private var persistence: Persistence
    private var notificationCenter: NotificationCenter
    private var userNotifications: UNUserNotificationCenter
    private var application: UIApplication
    
    @Published var showError = false
    @Published var errorMessage = ""
    

    // MARK: - Init -
    init(dataManager: SettingsDataManagerProtocol = SettingsDataManager(), secure: KeychainProvider = KeyChainData(), persistence: Persistence = LocalPersistence.shared, notificationCenter: NotificationCenter = .default, userNotifications:  UNUserNotificationCenter = .current(), application: UIApplication = .shared) {
        self.dataManager = dataManager
        self.secure = secure
        self.persistence = persistence
        self.notificationCenter = notificationCenter
        self.userNotifications = userNotifications
        self.application = application
    }

    // MARK: Public Methods
    func logout() {
        Task {
            await logOutByAPI()
            //KeyChainData().deleteStringKey(key: KeyChainEnum.user)
            //KeyChainData().deleteStringKey(key: KeyChainEnum.password)
            //persistence.setObject(value: false, forKey: .rememberLogin)
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                persistence.removePersistenceDomain(forName: bundleIdentifier)
            }
            notificationCenter.post(name: .logout, object: nil)
        }
    }

    func enableNotification(_ isEnabled: Bool) {
        activateNotifications(notifications: isEnabled)
    }

    func enableDarkTheme(_ isEnabled: Bool) {
        self.toggleDarkMode(isEnabled)
    }

    func enabledBiometrics(_ isEnabled: Bool) {
        //TODO: Biometrics
    }
}

private extension SettingsViewModel {
    func logOutByAPI() async {
        do {
            try await dataManager.logout()
        } catch {
            showErrorMessage(error)
        }
    }

    func activateNotifications(notifications: Bool) {
        if notifications {
            self.userNotifications.getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                } else {
                    self.userNotifications.requestAuthorization(options: [.alert,
                                                                                      .badge]
                    ) { granted, error in
                        granted ? print(granted) : print("\(error?.localizedDescription ?? "")")
                    }
                }
            }
        } else {
            userNotifications.removeAllPendingNotificationRequests()
        }
    }

    func toggleDarkMode(_ isEnabled: Bool) {
        if let windowScene = application.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
          
            windows.forEach { window in
                window.overrideUserInterfaceStyle = isEnabled ? .dark : .light
                
            }
        }
    }
    
    //MARK: private methods
    func showErrorMessage(_ error: Error) {
        showError.toggle()
        if let error = error as? PasswordValidator.PasswordError {
            errorMessage = error.description
        } else {
            errorMessage = "There has been a error"
        }
    }
}
