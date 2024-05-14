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
    
        setHostingControllerView(view, hostingController: hostingController)
        
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
