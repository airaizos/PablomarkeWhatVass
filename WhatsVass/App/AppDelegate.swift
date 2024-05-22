//
//  AppDelegate.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import UIKit
import UserNotifications
//import IQKeyboardManagerSwift

typealias NotificationPresentation = (UNNotificationPresentationOptions) -> Void
//@UIApplicationMain
/*final class AppDelegate333: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [
            .alert,
            .badge,
            .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions,
                                                                completionHandler: { _, _ in })
        application.registerForRemoteNotifications()

        let notificationOption = launchOptions?[.remoteNotification]
        if notificationOption as? [String: AnyObject] != nil {
        }

        // MARK: - Navigation Bar -
        let myNavigationBar =  UINavigationBar.appearance()
        myNavigationBar.backgroundColor = AssetsColors.main
        myNavigationBar.barTintColor = AssetsColors.contrast
        myNavigationBar.tintColor = AssetsColors.contrast
        myNavigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backButton = UIBarButtonItem.appearance()
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0),
                                           NSAttributedString.Key.foregroundColor: UIColor.white],
                                          for: .normal)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AssetsColors.main
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

// MARK: - Extension for Notifications -
extension AppDelegate333: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        print("New notification")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping NotificationPresentation) {
        completionHandler(UNNotificationPresentationOptions(rawValue: 0))
        print("New notification")
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
        print("New notification")
        return .newData
    }
}
*/
