//
//  KeyChain.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 16/5/24.
//

import Foundation
import CryptoKit

/*
 No push
 */

final class Crypto: KeychainProvider {
    static let shared = Crypto()
    @KeyChain(key:KeyChainEnum.userId) private var userIDKey = "".data(using: .utf8)
    @KeyChain(key:KeyChainEnum.user) private var usernameKey = "".data(using: .utf8)
    @KeyChain(key:KeyChainEnum.password) private var passwordKey = "".data(using: .utf8)
    @KeyChain(key:KeyChainEnum.password) private var tokenKey = "".data(using: .utf8)
    
    func getUsername() -> String? {
        getKey(usernameKey)
    }
    
    func setUserAndPassword(_ user: String, _ password: String) {
        usernameKey = user.data(using: .utf8)
        passwordKey = password.data(using: .utf8)
    }
    
    func deleteUserAndPasword() {
        usernameKey = nil
        passwordKey = nil
    }
    
    func getUserAndPassword() -> (String?, String?) {
        (getKey(usernameKey), getKey(passwordKey))
    }
    
    func setToken(_ token: String) {
        tokenKey = token.data(using: .utf8)
    }
    
    func getToken() -> String? {
        getKey(tokenKey)
    }
    
    func setUserId(_ id: String) {
        userIDKey = id.data(using: .utf8)
    }
    
    func getUserId() -> String? {
        getKey(userIDKey)
    }
    
   private func getKey(_ key: Data?) -> String? {
        guard let key else { return nil }
        return String(data: key, encoding: .utf8)
    }
}


@propertyWrapper
public struct KeyChain {
    public let key:String
    
    public init(wrappedValue: Data?, key: String) {
        self.key = key
        
        if SecKeyStore.shared.readKey(label: key) == nil {
            self.wrappedValue = wrappedValue
        }
    }
    
    public var wrappedValue:Data? {
        get {
            SecKeyStore.shared.readKey(label: key)
        }
        set {
            if let value = newValue {
                SecKeyStore.shared.storeKey(key: value, label: key)
            } else {
                SecKeyStore.shared.deleteKey(label: key)
            }
        }
    }
    
}

public final class SecKeyStore {
    static let shared = SecKeyStore()
    
    ///#CREACIÓN DEL DATO. GUARDAR UN DATO CUALQUIERA EN EL KEYCHAIN
    ///Key: Todo lo que se almacena en el KeyChain es Data
    ///Label: Cuenta atribuida, no es obligatorio que sea único. Varios elementos con el mismo nombre
    ///Type:Cadena de C CFString. Variable de C. Normalmente es el GenericPassword
    public func storeKey(key:Data,label:String,type:CFString = kSecClassGenericPassword) {
            
        ///Query:Obligatoriamente String:Any
        let query = [
            kSecClass: type,
            kSecAttrAccount: label,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecUseDataProtectionKeychain: true,
            kSecValueData: key
        ] as [String:Any]
        
        ///Nos aseguramos que no exista ya esa clave
        if readKey(label: label, type: type) == nil {
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            if status != errSecSuccess {
                print("::: Error grabando el \(label). Status: \(status) :::")
            }
            
        } else {
            ///Si ya existe, hay que acutalizar el dato
            let attributes = [
                kSecAttrAccount: label,
                kSecValueData: key
            ] as [String:Any]
            
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            
            if status != errSecSuccess {
                print("::: Error grabando el \(label). Status: \(status) :::")
            }
        }
    }
    
    ///#LECTURA DE DATOS DEL KEYCHAIN
    public func readKey(label:String, type:CFString = kSecClassGenericPassword) -> Data? {
        
        let query = [
            kSecClass: type,
            kSecAttrAccount: label,
            kSecUseDataProtectionKeychain: true,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String:Any]
        
        ///Para devolver un elemento creo el item
        var item:AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status != errSecSuccess {
            return nil
        } else {
            return item as? Data
        }
    }
    
    ///#DELETE KEY
    ///Borra todos los registros con el mismo label
    
    public func deleteKey(label:String, type:CFString = kSecClassGenericPassword) {
        
        let query = [
            kSecClass: type,
            kSecAttrAccount: label,
        ] as [String:Any]
        
        let result = SecItemDelete(query as CFDictionary)
        
        if result == noErr {
            print("Item \(label) borrado.")
        }
    }
}

