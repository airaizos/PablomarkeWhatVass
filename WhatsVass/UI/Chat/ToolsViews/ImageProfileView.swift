//
//  ImageProfileView.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 26/3/24.
//

import SwiftUI

struct ImageProfileView: View {
    var avatar: URL?
    var onlineColor: Color
    var body: some View {
        ZStack {
            Image(systemName: "person.fill")
                .foregroundColor(.gray)
                .shadow(color: .black, radius: 2, x: 1, y: 2)
                .padding()
                .font(.title)
           
                Circle()
                    .stroke(lineWidth: 1)
                    .frame(width:9)
                    .foregroundColor(onlineColor.opacity(0.7))
                    .offset(x: 12, y: 12)
                    .overlay (
                        Circle()
                            .frame(width:8)
                            .foregroundColor(onlineColor)
                            .blur(radius: 1)
                            .offset(x: 12, y: 12)
                    )
                    
        }
        .background(Circle().stroke(.gray, lineWidth: 1).padding(5))
    }
}

#Preview {
    VStack {
        ImageProfileView(avatar: nil,onlineColor: .red)
        ImageProfileView(onlineColor: .green)
    }
}
