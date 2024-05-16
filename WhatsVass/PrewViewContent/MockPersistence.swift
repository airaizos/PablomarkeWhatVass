//
//  MockPersistence.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 16/5/24.
//

import Foundation

final class MockPersistence: Persistence {
    func removeObject(forKey: Preferences) {
        
    }
    
    func setObject<T>(value: T, forKey: Preferences) where T : Hashable {
        
    }
    
    func getString(forKey: Preferences) -> String? {
        ""
    }
    
    func getBool(forKey: Preferences) -> Bool {
        true
    }
    
    func removePersistenceDomain(forName name: String) {
        
    }
}
