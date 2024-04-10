//
//  LabelExtension.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import UIKit

extension UILabel {
    func chatVassStyle(text: String, size: Int = 22, textColor: UIColor = AssetsColors.customWhite ?? .white) {
        self.text = NSLocalizedString(text,
                                      comment: "")
        self.textColor = textColor
        self.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
    }
}
