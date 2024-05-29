//
//  UIImageExtension.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 15/5/24.
//

import SwiftUI


extension UIImage {
    func resizeImage(_ size: CGFloat) -> UIImage? {
        let width:CGFloat = size
        
        let scale:CGFloat = width / self.size.width
        let height:CGFloat = self.size.height * scale
        
        #if os(iOS)
        return self.preparingThumbnail(of: CGSize(width: width, height: height))
        #endif
        
        //MARK: En watch OS preparingThumbnail no está implementada
        #if os(watchOS)
        return self
        #endif
    }
    
    convenience init?(from image: Image?, size: CGFloat) {
        guard let image else { return nil }
        let controller = UIHostingController(rootView: image)
        let view = controller.view

        let targetSize = CGSize(width: size, height: size) // Ajusta esto según tus necesidades
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let rawImage = renderer.image { context in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }

        self.init(cgImage: rawImage.cgImage!)
    }
}

