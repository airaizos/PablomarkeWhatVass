//
//  UITextFieldExtension.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 8/3/24.
//

import UIKit

extension UITextField {
    private struct Constants {
        static let buttonFrame = CGRect(x: -5, y: 0, 
                                        width: 20, height: 20)
        static let containerFrame = CGRect(x: 0, y: 0, 
                                           width: 30, height: 20)
        static let cornerRadius: CGFloat = 16.0
        static let fontSize: CGFloat = 16.0
    }

    func chatVassStyle(_ text: String, secure: Bool = false, textColor: UIColor = AssetsColors.darkMode) {
        self.textAlignment = .left
        self.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        self.layer.cornerRadius = Constants.cornerRadius
        self.backgroundColor = .customWhite
        self.clipsToBounds = true
        let attributes = [NSAttributedString.Key.foregroundColor: AssetsColors.darkMode]
        self.attributedPlaceholder = NSAttributedString(string: NSLocalizedString(text, comment: ""),
                                                        attributes: attributes as [NSAttributedString.Key: Any])
        self.autocorrectionType = .no
        self.isSecureTextEntry = secure
        self.textColor = textColor

        if secure {
            addSecureTextEntryToggle()
        }
    }

    private func addSecureTextEntryToggle() {
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye.slash.fill")?.withRenderingMode(.alwaysTemplate),
                              for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye.fill")?.withRenderingMode(.alwaysTemplate), 
                              for: .selected)
        toggleButton.tintColor = AssetsColors.darkMode
        toggleButton.frame = Constants.buttonFrame
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), 
                               for: .touchUpInside)
        toggleButton.accessibilityLabel = "Toggle Password Visibility"

        let container = UIView(frame: Constants.containerFrame)
        container.addSubview(toggleButton)

        self.rightView = container
        self.rightViewMode = .always
    }

    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        sender.isSelected = !sender.isSelected
    }
}
