//
//  VassToggle.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct VassToggle: View {
    @Binding var isOn: Bool
    var size: Double = 50
    var action: () -> ()
    var body: some View {
        Button {
            withAnimation {
                isOn.toggle()
            }
            action()
        }label: {
            ZStack(alignment:isOn ?.trailing : .leading) {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.dark,lineWidth: 2)
                    .shadow(color: isOn ? .darkDarkmode : .white.opacity(0.7), radius: 0, x: 2, y: 0)
                    .shadow(color: isOn ? .darkDarkmode : .white.opacity(0.7), radius: 0, x: 1, y: 1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(isOn ? .darkDarkmode : .white)
                    )
                
                Circle()
                    .stroke(.dark, lineWidth: 5)
                    .overlay(
                        Circle()
                            .foregroundStyle(
                                RadialGradient(colors: [.darkDarkmode.opacity(0.3), .darkDarkmode], center: .center, startRadius: size, endRadius: 0)
                            )
                    )
                    .frame(width: size * 0.5)
                    .padding(isOn ? .trailing : .leading, 2)
            }
        }
        .frame(width: size, height: 30)
    }
}

#Preview {
    VassToggle(isOn: .constant(true)) { }
}
