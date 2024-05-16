//
//  PhotosPickerExtension.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 15/5/24.
//

import SwiftUI
import PhotosUI

extension PhotosPickerItem {
    @MainActor
    func convert() async -> Image {
        do {
            if let data = try await self.loadTransferable(type: Data.self) {
                if let uiimage = UIImage(data: data), let resizedUuimage = uiimage.resizeImage(250) {
                    return Image(uiImage: resizedUuimage)
                }
            }
        } catch {
            //no se ha podido cargar la imagen
            return Image(systemName: "person.crop.circle")
        }
        return Image(systemName: "person.crop.circle")
    }
}
