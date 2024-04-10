//
//  BaseViewController.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 18/3/24.
//

import UIKit

class BaseViewController: UIViewController {
    func prepareAndConfigView(titleForView: String, navBarHidden: Bool = false) {
        prepareForTapAndDismissKeyboard()
        configViews()
        configNavigationBar(titleNav: titleForView,
                            navBarHidden: navBarHidden)
    }

    func showAlertSimple(title: String, message: String) {
        let alert = UIAlertController(title: NSLocalizedString(title,
                                                               comment: ""),
                                      message: NSLocalizedString(message,
                                                                 comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default))
        self.present(alert, animated: true)
    }

    func showSelectAlert(title: String,
                         message: String,
                         yesAction: (() -> Void)? = nil,
                         cancelAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: NSLocalizedString(title, 
                                                               comment: ""),
                                      message: NSLocalizedString(message, 
                                                                 comment: ""),
                                      preferredStyle: .alert)

        let yesButton = UIAlertAction(title: NSLocalizedString("Yes",
                                                               comment: ""),
                                      style: .default) { _ in
            yesAction?()
        }
        let noButton = UIAlertAction(title: NSLocalizedString("No",
                                                              comment: ""),
                                     style: .default) { _ in
            cancelAction?()
        }
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert,
                     animated: true)
    }
}

private extension BaseViewController {
    func prepareForTapAndDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func configNavigationBar(titleNav: String, navBarHidden: Bool ) {
        title = NSLocalizedString(titleNav,
                                  comment: "")
        self.navigationController?.navigationBar.isHidden = navBarHidden

    }
    
    func configViews() {
        self.view.backgroundColor = AssetsColors.softdarkmode
    }
}

// MARK: - Extension for textField -
extension BaseViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
}
