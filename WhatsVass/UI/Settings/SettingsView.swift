//
//  SettingsView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @AppStorage(Preferences.notifications.rawValue) var isNotificationsOn = false
    @AppStorage(Preferences.themes.rawValue) var isDarkThemeOn = false
    @AppStorage(Preferences.biometrics.rawValue) var isBiometricOn = false
    
    var body: some View {
        VStack {
            ToggleRow(isOn: $isNotificationsOn, title: "Notifications") {
                viewModel.enableNotification(isNotificationsOn)
            }
            
            ToggleRow(isOn: $isDarkThemeOn, title: "Themes") {
                viewModel.enableDarkTheme(isDarkThemeOn)
            }
            ToggleRow(isOn: $isBiometricOn, title: "Biometrics") {
                viewModel.enabledBiometrics(isBiometricOn)
            }
            Spacer()
            VassButton(title: "Logout") {
                viewModel.logout()
            }
        }
        .padding()
        .animation(.bouncy.delay(0.1), value: isNotificationsOn)
        .vassBackground()
    }
}

#Preview {
    SettingsView(viewModel: .preview)
}

protocol SettingsDelegate {
    func logoutButton()
    func isBiometricsActive(_ isOn: Bool)
    func isNotificationsActive(_ isOn: Bool)
    func isDarkThemeActive(_ isOn: Bool)
}
