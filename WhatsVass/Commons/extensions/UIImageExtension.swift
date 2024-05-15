//
//  UIImageExtension.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 15/5/24.
//

import UIKit


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
}
