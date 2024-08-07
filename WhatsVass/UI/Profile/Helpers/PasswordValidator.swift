//
//  PasswordValidator.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 14/5/24.
//

import Foundation

struct PasswordValidator {
        
    @discardableResult
    func isValid(_ text: String) throws -> Bool {
        try verifyIfContainsWhiteSpaces(text)
        try verifyIfItsTooShort(text)
        try verifyNotContainsASymbol(text)
        return true
    }
    
    @discardableResult
    func isStrongPassword(_ text: String) throws -> Bool {
        try verifyIfContainsWhiteSpaces(text)
        try verifyIfItsTooShort(text)
        try verifyIfContainsAnyNumber(text)
        try verifyIfContainsAnyUppercased(text)
        try verifyIfContainsAnyLowercased(text)
        try verifyIfContainsAnySymbol(text)
        try verifyIfContainsConsecutiveCharacters(text)
        
        return true
    }
    
    private func verifyIfContainsWhiteSpaces(_ text: String) throws {
        guard !text.contains(" ") else { throw PasswordError.whiteSpaces }
    }
    private func verifyIfItsTooShort(_ text: String) throws {
        guard text.count >= 6 else { throw PasswordError.tooShort }
    }
    
    private func verifyIfContainsAnyNumber(_ text: String) throws {
        let regexNumber = try Regex(".*\\d+.*")
        guard text.contains(regexNumber) else { throw PasswordError.noNumbers }
    }
    
    private func verifyIfContainsAnyUppercased(_ text: String) throws {
        let regexUppercased = try Regex ("[A-Z]")
        guard text.contains(regexUppercased) else { throw PasswordError.noUppercased }
    }
    
    private func verifyIfContainsAnyLowercased(_ text: String) throws {
        let regexLowercased = try Regex( "[a-z]")
        guard text.contains(regexLowercased) else { throw PasswordError.noLowercased }
    }
    
    private func verifyIfContainsAnySymbol(_ text: String) throws {
        let regexSymbols = try Regex("[^a-zA-Z0-9]")
        guard text.contains(regexSymbols) else { throw PasswordError.noSymbols }
    }
    
    private func verifyIfContainsConsecutiveCharacters(_ text: String) throws {
        let regexConsecutiveCharacters = try Regex(#"(.)\1\1"#)
        guard !text.contains(regexConsecutiveCharacters) else { throw PasswordError.consecutiveCharacters }
        
    }
    
    private func verifyNotContainsASymbol(_ text: String) throws {
        let regexSymbols = try Regex("[^a-zA-Z0-9]")
        guard !text.contains(regexSymbols) else { throw UserError.symbols }
    }
    
    enum PasswordError: Error {
        case tooShort, noNumbers, noUppercased, noLowercased, noSymbols, consecutiveCharacters, whiteSpaces
        
        var description: String {
            switch self {
            case .tooShort: "Demasiado corta"
            case .noNumbers: "Incluye al menos 1 número"
            case .noUppercased: "Incluye al menos una mayúscula"
            case .noLowercased: "Incluye al menos minúscula"
            case .noSymbols: "Incluye al menos 1 símbolo *?-_@%&"
            case .consecutiveCharacters: "No utilices el mismo caracter seguido"
            case .whiteSpaces: "Quita los espacios en blanco"
            }
        }
    }
    
    enum UserError: Error {
        case tooShort, symbols, whiteSpaces
        
        var description: String {
            switch self {
            case .tooShort: "Demasiado corto"
            case .symbols: "No debe incluir símbolos"
            case .whiteSpaces: "No debe incluir espacios en blanco"
            }
        }
    }
}
