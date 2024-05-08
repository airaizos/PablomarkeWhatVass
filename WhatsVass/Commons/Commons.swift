//
//  Commons.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import Foundation

func saveCodableToDocumentsDirectory<T: Codable>(_ codable: T, fileName: String) {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    if let data = try? encoder.encode(codable) {
        try? data.write(to: fileURL)
        print("Archivo guardado en: \(fileURL)")
    } else {
        print("No se ha podido guardar en: \(fileURL)")
    }
}
