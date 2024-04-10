//
//  ImageProfileView.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 26/3/24.
//

import SwiftUI

struct ImageProfileView: View {
    var onlineColor: Color
    var body: some View {
        ZStack {
            Image(systemName: "person.fill")
                .foregroundColor(.white)
                .padding()
                .font(.system(size: 28))
            Image(systemName: "circle.fill")
                .font(.system(size: 8))
                .foregroundColor(onlineColor)
                .offset(x: 12, y: 12)
        }    }
}

#Preview {
    ImageProfileView(onlineColor: .red)
}
