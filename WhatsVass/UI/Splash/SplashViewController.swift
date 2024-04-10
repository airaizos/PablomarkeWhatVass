//
//  SplashViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import UIKit
import Combine

class SplashViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var aiSpinner: UIActivityIndicatorView!
    @IBOutlet weak var ivLogoBass: UIImageView!

    // MARK: - Properties
    private var viewModel: SplashViewModel?
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAndConfigView(titleForView: "",
                             navBarHidden: true)
        configView()
        responseViewModel()
        viewModel?.initView()
    }

    // MARK: - Public methods
    func set(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Private extension for metohds -
private extension SplashViewController {
    func configView() {
        aiSpinner.startAnimating()
        aiSpinner.style = .large
        ivLogo.image = AssetsImages.logo
        ivLogoBass.image = AssetsImages.vassLogo
    }

    func responseViewModel() {
        viewModel?.loginExist.sink(receiveValue: { _ in
             self.navigateToLogin()
        }).store(in: &cancellables)
    }

    // MARK: - Navigation
    func navigateToLogin() {
        LoginWireframe().push(navigation: self.navigationController)
    }
}
