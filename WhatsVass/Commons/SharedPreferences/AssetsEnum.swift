//
//  AssetsEnum.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 21/3/24.
//

import UIKit

enum AssetsImages {
    static let logo: UIImage = UIImage(named: "logo") ?? UIImage()
    static let vassLogo: UIImage = UIImage(named: "vassLogo") ?? UIImage()
}

enum AssetsColors {
    static let soft: UIColor = UIColor(named: "soft") ?? .blue
    static let dark: UIColor = UIColor(named: "dark") ?? .blue
    static let main: UIColor = UIColor(named: "main") ?? .blue
    static let contrast: UIColor = UIColor(named: "contrast") ?? .purple
    static let customWhite: UIColor = UIColor(named: "customWhite") ?? .white
    static let darkMode: UIColor = UIColor(named: "dark_darkmode") ?? .blue
    static let softdarkmode: UIColor = UIColor(named: "soft_darkmode") ?? .blue
    static let letter: UIColor = UIColor(named: "letterColor") ?? .blue
}
