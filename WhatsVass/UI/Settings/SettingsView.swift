//
//  SettingsView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.theme) private var theme: Theme
    @EnvironmentObject var viewModel: SettingsViewModel
    @AppStorage(Preferences.notifications.rawValue) var isNotificationsOn = false
    @AppStorage(Preferences.themes.rawValue) var isDarkThemeOn = false
    @AppStorage(Preferences.biometrics.rawValue) var isBiometricOn = false
    
    @AppStorage(Preferences.nickname.rawValue) var userNickname = ""
    @AppStorage(Preferences.avatar.rawValue) var userAvatar = ""
    @AppStorage(Preferences.id.rawValue) var userId = ""
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: userAvatar)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundStyle(.white)
            }
        
            Text(userNickname)
                .font(.title)
            
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
        .vassBackground(theme)
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel.preview)
}

protocol SettingsDelegate {
    func logoutButton()
    func isBiometricsActive(_ isOn: Bool)
    func isNotificationsActive(_ isOn: Bool)
    func isDarkThemeActive(_ isOn: Bool)
}
