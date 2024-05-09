//
//  SplashViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import SwiftUI

final class SplashViewController: BaseViewController, SplashDelegate {

    // MARK: - Properties
    private var viewModel: SplashViewModel?

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let splashView = SplashView(delegate: self)
        let hostingController =  UIHostingController(rootView: splashView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
        
        prepareAndConfigView(titleForView: "",
                             navBarHidden: true)
        viewModel?.initPreferences()
    }

    // MARK: - Public methods
    func set(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }
    
    func navigateToLogin() {
        LoginWireframe().push(navigation: self.navigationController)
    }
}
