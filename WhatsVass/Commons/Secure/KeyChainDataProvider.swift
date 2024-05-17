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
    func deleteUserAndPasword(_ user: String, _ password: String)
    func getUserAndPassword() -> (String?, String?)
    func setToken(_ token: String)
    func getToken() -> String?
}

final class KeyChainData: KeychainProvider {
    let keychain = KeychainSwift()

    private func setStringKey(value: String, key: String ) {
        keychain.set(value, forKey: key)
    }

    private func getStringKey(key: String) -> String? {
        keychain.get(key)
    }

    private func deleteStringKey(key: String) {
        keychain.delete(key)
    }

    func allKeysDelete() {
        keychain.clear()
    }

    func setUserAndPassword(_ user: String, _ password: String) {
        setStringKey(value: user,
                     key: KeyChainEnum.user)
        setStringKey(value: password,
                     key: KeyChainEnum.password)
    }
    
    func deleteUserAndPasword(_ user: String,_ password: String) {
      deleteStringKey(key: user)
        deleteStringKey(key: password)
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
}
