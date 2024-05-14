//
//  LogoVassView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 13/5/24.
//

import SwiftUI

struct LogoVassView: View {
    var body: some View {
        Image(uiImage: AssetsImages.logo)
            .resizable()
            .scaledToFit()
            .frame(width: 334)
            .padding(.top,50)
    }
}

#Preview {
    LogoVassView()
}
