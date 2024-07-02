//
//  KeyChainDataProvider.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 19/3/24.
//

import Foundation
import KeychainSwift

protocol KeychainProvider {
    func setUserAndPassword(_ user: String, _ password: String)
    func deleteUserAndPasword()
    func getUserAndPassword() -> (String?, String?)
    func setToken(_ token: String)
    func getToken() -> String?
    func setUserId(_ id: String)
    func getUserId() -> String?
    func getUsername() -> String?
}

final class KeyChainData: KeychainProvider {
   
    let keychain = KeychainSwift()
    
    func getUsername() -> String? {
        getStringKey(key: KeyChainEnum.user)
    }
    
    func allKeysDelete() {
        keychain.clear()
    }

    func setUserId(_ id: String) {
        setStringKey(value: KeyChainEnum.userId, key: id)
    }
    func getUserId() -> String? {
        getStringKey(key: KeyChainEnum.userId)
    }
    
    func setUserAndPassword(_ user: String, _ password: String) {
        setStringKey(value: user,
                     key: KeyChainEnum.user)
        setStringKey(value: password,
                     key: KeyChainEnum.password)
    }
    
    func deleteUserAndPasword() {
        deleteStringKey(key: KeyChainEnum.user)
        deleteStringKey(key: KeyChainEnum.password)
    }
    
    func getUserAndPassword() -> (String?, String?) {
      (getStringKey(key: KeyChainEnum.user),getStringKey(key: KeyChainEnum.password))
    }
    
    func setToken(_ token: String) {
        setStringKey(value: token, key: KeyChainEnum.token)
    }
    
    func getToken() -> String? {
        getStringKey(key: KeyChainEnum.token)
    }
    
    
    private func setStringKey(value: String, key: String ) {
        keychain.set(value, forKey: key)
    }

    private func getStringKey(key: String) -> String? {
        keychain.get(key)
    }

    private func deleteStringKey(key: String) {
        keychain.delete(key)
    }
}
