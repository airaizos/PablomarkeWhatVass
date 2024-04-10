//
//  ProfileViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import UIKit
import Combine

final class ProfileViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var vImage: UIView!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var btImageSelector: UIButton!
    @IBOutlet weak var svProfile: UIStackView!
    @IBOutlet weak var btCreateProfile: UIButton!
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfNick: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRepeatPassword: UITextField!

    // MARK: - Properties
    private var viewModel: ProfileViewModel?
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        prepareAndConfigView(titleForView: "Create profile")
        responseViewModel()
    }

    // MARK: - Public methods
    func set(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Buttons
    @IBAction func btaImageSelector(_ sender: Any) {
        present(createImagesPicker(),
                animated: true,
                completion: nil)
    }
    @IBAction func btaCreateProfile(_ sender: Any) {
        viewModel?.comprobeText(user: self.tfUser.text!,
                                nick: self.tfNick.text!,
                                password: self.tfPassword.text!,
                                repeatPassword: self.tfRepeatPassword.text!)
    }
}

// MARK: - Private extension for metohds -
private extension ProfileViewController {
    func configView() {
        configButton()
        configTextField()
        configImageView()
    }

    func configButton() {
        btCreateProfile.chatVassStyle("Sign in")
    }

    func configTextField() {
        tfUser.chatVassStyle("User")
        tfUser.delegate = self
        tfNick.chatVassStyle("Nick")
        tfNick.delegate = self
        tfPassword.chatVassStyle("Password",
                                 secure: true)
        tfPassword.delegate = self
        tfRepeatPassword.chatVassStyle("RepeatPassword",
                                       secure: true)
        tfRepeatPassword.delegate = self
    }

    func configImageView() {
        vImage.backgroundColor = .clear
        ivProfile.backgroundColor = .customWhite
        if let personImage = UIImage(systemName: "person.fill") {
            let redPersonImage = personImage.withRenderingMode(.alwaysTemplate)
            ivProfile.image = redPersonImage
            ivProfile.tintColor = .main
        }
        
        ivProfile.layer.cornerRadius = ivProfile.frame.height / 2
        ivProfile.contentMode = .scaleAspectFill
        btImageSelector.setImage(UIImage(systemName: "camera"),
                                 for: .normal)
        btImageSelector.tintColor = .main
        btImageSelector.layer.cornerRadius = btImageSelector.bounds.width / 2
        btImageSelector.layer.masksToBounds = true
    }

    func createImagesPicker() -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
       return imagePicker
    }

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

// MARK: - Extensions for delegates
extension ProfileViewController: UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            viewModel?.addImage(image: image)
            if let image = viewModel?.getImage() {
                ivProfile.image = image
            }
        }
        picker.dismiss(animated: true,
                       completion: nil)
    }
}
