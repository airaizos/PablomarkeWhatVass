//
//  Preview+Bundle.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import Foundation

extension Bundle {
    
    static func decode<T: Codable>(type: T.Type, from file: String) throws -> T {
        let url = self.main.url(forResource: file, withExtension: "json")!
        if let data = try? Data(contentsOf: url), let items = try? JSONDecoder().decode(type, from: data) {
            return items
        } else {
            throw BaseError.noCodable
        }
    }
}
