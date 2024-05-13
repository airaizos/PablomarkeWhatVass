//
//  KeyChainDataProvider.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 19/3/24.
//

import Foundation
import KeychainSwift

protocol KeychainProvider {
    func setStringKey(value: String, key: String)
    func getStringKey(key: String) -> String?
    func deleteStringKey(key: String)
    func allKeysDelete()
}

final class KeyChainData: KeychainProvider {
    let keychain = KeychainSwift()

    func setStringKey(value: String, key: String ) {
        keychain.set(value, forKey: key)
    }

    func getStringKey(key: String) -> String? {
        keychain.get(key)
    }

    func deleteStringKey(key: String) {
        keychain.delete(key)
    }

    func allKeysDelete() {
        keychain.clear()
    }

    func setLoginAndPassword(user: String, password: String) {
        setStringKey(value: user,
                     key: KeyChainEnum.user)
        setStringKey(value: password,
                     key: KeyChainEnum.password)
    }
}
