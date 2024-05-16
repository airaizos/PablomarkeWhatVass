//
//  ViewExtensions.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

extension View {
    func vassBackground() -> some View {
        self
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                LinearGradient(colors: [Color.darkDarkmode.opacity(0.5),Color.darkDarkmode.opacity(0.7),Color.darkDarkmode.opacity(0.9),Color.darkDarkmode], startPoint: .top, endPoint: .bottom)
            )
    }
    
    func hideKeyboard() {
        UIApplication
            .shared
            .sendAction(#selector(UIResponder.resignFirstResponder),
                        to: nil, from: nil, for: nil)
    }
}
