//
//  VassTextField.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 14/5/24.
//

import SwiftUI

    struct VassTextField<Content:View>: View {
        var systemImage: String
        @ViewBuilder let content: Content
        
        init(systemImage: String = "person", text: String, @ViewBuilder content: () -> Content) {
            self.systemImage = systemImage
            self.content = content()
        }
        var body: some View {
            HStack {
                Image(systemName: systemImage)
                    .foregroundStyle(.white.opacity(0.9))
                    .frame(width: 30)
                content
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.darkDarkmode,lineWidth: 3)
                    )
                //TODO: Hay que hacerlo dinámico
//                Image(systemName: isValid ? "checkmark.circle" : "xmark.circle")
//                        .symbolRenderingMode(.palette)
//                        .foregroundStyle(.white, isValid ? .green : .red)
            }
            .shadow(color: .black.opacity(0.8), radius: 5, x:2,y:3)
        }
    }

