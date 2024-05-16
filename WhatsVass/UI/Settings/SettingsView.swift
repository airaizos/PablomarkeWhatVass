//
//  SettingsView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct SettingsView: View {
    @State var isNotificationsOn = false
    @State var isDarkThemeOn = false
    @State var isBiometricOn = false
    var delegate: SettingsDelegate?
    var body: some View {
        VStack {
            ToggleRow(isOn: $isNotificationsOn, title: "Notifications") {
                delegate?.isNotificationsActive(isNotificationsOn)
            }
            
            ToggleRow(isOn: $isDarkThemeOn, title: "Themes") {
                delegate?.isDarkThemeActive(isDarkThemeOn)
            }
            ToggleRow(isOn: $isBiometricOn, title: "Biometrics") {
                delegate?.isBiometricsActive(isBiometricOn)
            }
            Spacer()
            VassButton(title: "Logout") {
                delegate?.logoutButton()
            }
        }
        .padding()
        .animation(.bouncy.delay(0.1), value: isNotificationsOn)
        .vassBackground()
    }
}

#Preview {
    SettingsView()
}

protocol SettingsDelegate {
    func logoutButton()
    func isBiometricsActive(_ isOn: Bool)
    func isNotificationsActive(_ isOn: Bool)
    func isDarkThemeActive(_ isOn: Bool)
}
