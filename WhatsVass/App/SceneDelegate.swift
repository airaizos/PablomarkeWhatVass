//
//  SceneDelegate.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import UIKit
import Combine

final class SceneDelegate: UIResponder,
                     UIWindowSceneDelegate {

    var window: UIWindow?
    var apiClient = BaseAPIClient()
    var cancellables: Set<AnyCancellable> = []

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        let home = SplashWireframe().viewController
        let navigationController = UINavigationController(rootViewController: home)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        disconnectedNow(online: false)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
        disconnectedNow(online: false)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        disconnectedNow(online: true)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        disconnectedNow(online: false)
    }
}

extension SceneDelegate {
    func disconnectedByAPI(online: Bool) -> AnyPublisher <LogOutResponse, BaseError> {
        let url = EndpointsUsers.online + String(online)
        return apiClient.requestPublisher(relativePath: url,
                                          method: .put)
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func disconnectedNow(online: Bool) {
        disconnectedByAPI(online: online)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Error \(error)")
                }
            } receiveValue: { offline in
                print(offline.message)
            }.store(in: &cancellables)
    }
}
