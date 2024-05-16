//
//  LocalPersistence.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 15/5/24.
//

import Foundation

protocol Persistence {
    func removeObject(forKey: Preferences)
    func setObject<T: Hashable>(value: T, forKey: Preferences)
    func getString(forKey: Preferences) -> String?
    func getBool(forKey: Preferences) -> Bool
    func removePersistenceDomain(forName name: String)
}

final class LocalPersistence: Persistence {
    static let shared = LocalPersistence()
    
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    private var defaults = UserDefaults.standard
    
    func removeObject(forKey: Preferences) {
        defaults.removeObject(forKey: forKey.rawValue)
    }
    
    func setObject<T: Hashable>(value: T, forKey: Preferences) {
        UserDefaults.standard.set(value, forKey: forKey.rawValue)
    }
    
    func getString(forKey: Preferences) -> String? {
        UserDefaults.standard.string(forKey: forKey.rawValue)
    }
    
    func getBool(forKey: Preferences) -> Bool {
        UserDefaults.standard.bool(forKey: forKey.rawValue)
    }
    
    func removePersistenceDomain(forName name: String) {
        defaults.removePersistentDomain(forName: name)
    }
}
