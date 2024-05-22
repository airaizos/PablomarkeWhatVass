//
//  WhatVassApp.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 17/5/24.
//

import SwiftUI

@main
struct WhatVassApp: App {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @AppStorage(Preferences.themes.rawValue) var isDarkThemeOn = false
    
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var splashViewModel = SplashViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    
    let inactive = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
    let active = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
    var apiClient = BaseAPIClient()
    
    @State var navState: NavState = .splash
    var body: some Scene {
        WindowGroup {
            Group {
                switch navState {
                case .splash: SplashView(navState: $navState)
                case .login: LoginView(navState: $navState)
                case .register: ProfileView()
                case .home: 
                    NavigationStack {
                        HomeView()
                    }
                        .environmentObject(homeViewModel)
                        .environmentObject(settingsViewModel)
                }
            }
            .onReceive(inactive) { _ in
                Task {
                    await isUserOnLine(false)
                }
            }
            .onReceive(active) { _ in
                Task {
                    await isUserOnLine(true)
                }
            }
            .onChange(of: settingsViewModel.isLoggedOut) { oldValue, newValue in
                if newValue {
                    navState = .login
                }
            }
            .preferredColorScheme(isDarkThemeOn ? .dark : .light)
        }
    }
    private func isUserOnLine(_ isOnLine: Bool) async {
        let url = EndpointsUsers.urlLogout //.appending(path:String(online))
        do {
            let _ = try await apiClient.fetchCodable(url: url, type: LogOutResponse.self)
        } catch {
            //error
        }
    }
}


enum NavState {
    case splash, login, register, home
}
