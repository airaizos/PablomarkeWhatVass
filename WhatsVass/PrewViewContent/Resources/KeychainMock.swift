//
//  KeychainMock.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import Foundation

final class KeychainMock: KeychainProvider {
    func setToken(_ token: String) {
        
    }
    
    func getToken() -> String? {
        ""
    }
    
    func deleteUserAndPasword(_ user: String, _ password: String) {
        
    }
    
    func setUserAndPassword(_ user: String,_ password: String) {
        //
    }
    func getUserAndPassword() -> (String?, String?) {
        ("","")
    }
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
