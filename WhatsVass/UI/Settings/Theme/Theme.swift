//
//  Theme.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 22/5/24.
//

import SwiftUI

struct Theme: Identifiable, Hashable {
    let name: String
    let accentColor: Color
    let secondaryColor: Color
    
    var id: String { name }
    
    static let dark = Theme(
        name: "dark",
        accentColor: .darkDarkmode,
        secondaryColor: .main)

    static let light = Theme(
        name: "light",
        accentColor: .main,
        secondaryColor: .soft)

    static let allThemes: [Theme] = [.dark, .light]
}

struct ThemeKey: EnvironmentKey {
    static let defaultValue = Theme.light
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue  }
    }
}

extension View {
    func theme(_ theme: Theme) -> some View {
        environment(\.theme, theme)
    }
}
