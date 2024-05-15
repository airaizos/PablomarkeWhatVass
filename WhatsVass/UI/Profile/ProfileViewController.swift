//
//  ProfileViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import SwiftUI
import Combine

protocol ProfileViewDelegate {
    func createProfile(user: String, nick: String, password: String, confirmPassword: String)
}


final class ProfileViewController: BaseViewController,ProfileViewDelegate {

    // MARK: - Properties
    private var viewModel: ProfileViewModel?
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAndConfigView(titleForView: "Create profile")
        responseViewModel()
        
        let profileView = ProfileView(delegate: self)
        let hostingController = UIHostingController(rootView: profileView)
        setHostingControllerView(view, hostingController: hostingController)
    }

    // MARK: - Public methods
    func set(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Buttons
//    @IBAction func btaImageSelector(_ sender: Any) {
//       // present(createImagesPicker(),
//         //       animated: true,
//           //     completion: nil)
//    }
//    @IBAction func btaCreateProfile(_ sender: Any) {
//        viewModel?.comprobeText(user: self.tfUser.text!,
//                                nick: self.tfNick.text!,
//                                password: self.tfPassword.text!,
//                                repeatPassword: self.tfRepeatPassword.text!)
//    }
    
    //MARK: Create Profile
    
    func createProfile(user: String, nick: String, password: String, confirmPassword: String) {
        //TODO: añadir imagen
        viewModel?.comprobeText(user: user, nick: nick, password: password, repeatPassword: confirmPassword)
    }
}

// MARK: - Private extension for metohds -
private extension ProfileViewController {

    func responseViewModel() {
        viewModel?.navigateToHomeView.sink { [weak self] _ in
            self?.navigateToHome()
        }.store(in: &cancellables)
        viewModel?.emptyField.sink(receiveValue: { [weak self]_ in
            self?.showAlertSimple(title: "EmptyField",
                                  message: "EmptyFieldText")
        }).store(in: &cancellables)
    }

    // MARK: - Navigation
    func navigateToHome() {
            HomeWireframe().push(navigation: navigationController)
    }
}
