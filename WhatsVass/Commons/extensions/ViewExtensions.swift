//
//  ViewExtensions.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

extension View {
    
    func vassBackground(_ theme: Theme) -> some View {
        self
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
//                LinearGradient(colors: [Color.darkDarkmode.opacity(0.5),Color.darkDarkmode.opacity(0.7),Color.darkDarkmode.opacity(0.9),Color.darkDarkmode], startPoint: .top, endPoint: .bottom)
//            )
//
                
        LinearGradient(colors: [theme.secondaryColor.opacity(0.5),theme.secondaryColor.opacity(0.7),theme.secondaryColor.opacity(0.9),theme.secondaryColor], startPoint: .top, endPoint: .bottom)
    )
    }
    
    func hideKeyboard() {
        UIApplication
            .shared
            .sendAction(#selector(UIResponder.resignFirstResponder),
                        to: nil, from: nil, for: nil)
    }
}



protocol ErrorHandling: ObservableObject {
     var showError: Bool { get set }
     var errorMessage: String { get set }
}


extension ObservableObject where Self: ErrorHandling {
    func showErrorMessage(_ error: Error) {
        if let error = error as? BaseError {
            errorMessage = error.description()
            showError.toggle()
        } else {
            showError.toggle()
            errorMessage = "There has been an error"
        }
    }
}
