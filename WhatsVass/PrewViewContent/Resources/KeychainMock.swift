//
//  KeychainMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import Foundation

final class KeychainMock: KeychainProvider {
    //TODO: No implementado
    func setStringKey(value: String, key: String) {
        //
    }
    
    func getStringKey(key: String) -> String? {
        ""
    }
    
    func deleteStringKey(key: String) {
        //
    }
    
    func allKeysDelete() {
        //
    }
}
