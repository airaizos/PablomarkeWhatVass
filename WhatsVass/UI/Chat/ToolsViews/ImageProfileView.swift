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
                .foregroundColor(.gray)
                .shadow(color: .black, radius: 2, x: 1, y: 2)
                .padding()
                .font(.title)
            ZStack {
                Circle()
                    .frame(width:8)
                    .foregroundColor(onlineColor)
                    .blur(radius: 1)
                    .offset(x: 12, y: 12)
                Circle()
                    .stroke(lineWidth: 1)
                    .frame(width:9)
                    .foregroundColor(onlineColor.opacity(0.7))
                    .offset(x: 12, y: 12)
            }
        }  
    }
}

#Preview {
    VStack {
        ImageProfileView(onlineColor: .red)
        ImageProfileView(onlineColor: .green)
    }
}
