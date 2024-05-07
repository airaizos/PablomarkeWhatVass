//
//  BaseError.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import Foundation

enum BaseError: Error {
    case generic
    case noInternetConnection
    case noToken
    case notAuthorized
    case noBiometrics
    case handler
    case failedURL
    case noURl
    case failedLogin
    case failedBiometricLogin
    case failedChatCreated
    case failedChat
    case noCodable

    func description() -> String {
        switch self {
        case .generic:
            "Generic error"
        case .noInternetConnection:
            "No internet conection"
        case .noToken:
            "No token Provided"
        case .notAuthorized:
            "Not authorized"
        case .noBiometrics:
            "No biometrics"
        case .handler:
            "Error in handler"
        case .failedURL:
            "Url Failed"
        case .noURl:
            "No URL"
        case .failedLogin:
            "Failed login"
        case .failedBiometricLogin:
            "Failed Biometric login"
        case .failedChatCreated:
            "Failed Chat Create"
        case .failedChat:
            "Failed Chat"
        case .noCodable:
            "Incorrect data"
        }
    }
}
