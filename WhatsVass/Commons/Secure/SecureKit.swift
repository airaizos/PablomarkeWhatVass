//
//  SecureKit.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 30/5/24.
//

import Foundation
import CryptoKit
/*
 No push
 */

final class HashKit {
    static let shared = HashKit()
    func sha256(value:String) throws -> String {
        guard let data = value.data(using: .utf8) else { throw CryptoErrors.StringNotConverted }
        
        let hash = SHA256.hash(data: data)
        let hashData = Data(hash.withUnsafeBytes( { Array($0) }))
        return hashData.base64EncodedString()
    }
}

enum CryptoErrors:Error {
    case dataNotConverted, base64NoConverted,badDecrypt,badEncrypt(Error)
    case nilCombined, StringNotConverted
}
