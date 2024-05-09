//
//  VassButton.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct VassButton: View {
    var title: String
    var action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            Text(LocalizedStringKey(title))
                .font(.title3)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.dark)
                        .padding(.horizontal,-50)
                        .padding(.vertical,-15)
                )
        }
        .frame(height: 50)
    }
}

#Preview {
    VassButton(title: "Biometrics"){ } 
}
