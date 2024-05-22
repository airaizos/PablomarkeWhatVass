//
//  LoginRegisterViewModel.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 22/5/24.
//

import SwiftUI

final class LoginRegisterViewModel: ObservableObject {
    enum Screen: String, CaseIterable, Identifiable {
        case login = "Login", register = "Register"
        
        var id: Self { self }
    }
    
}
