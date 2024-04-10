//
//  UISwitchExtension.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import UIKit

extension UISwitch {
    func chatVassStyle(large: Bool = true, isOn: Bool = false) {
        self.thumbTintColor = .main
        self.tintColor = .main
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderWidth = 4.0
        self.layer.borderColor = AssetsColors.main.cgColor
        self.transform = large ? CGAffineTransform(scaleX: 1.3,
                                                   y: 1.3) : CGAffineTransform(scaleX: 0.6,
                                                                               y: 0.6)
        self.isOn = isOn
    }
}
