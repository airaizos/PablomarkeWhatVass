//
//  UIButtonExtension.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 8/3/24.
//

import UIKit

extension UIButton {
    func chatVassStyle(_ text: String) {
        self.setTitle(NSLocalizedString(text,
                                        comment: ""),
                      for: .normal)
        self.setTitleColor(AssetsColors.customWhite,
                                           for: .normal)
        self.tintColor = AssetsColors.main
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 184),
            self.heightAnchor.constraint(equalToConstant: 48)
                ])
    }
}
