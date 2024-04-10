//
//  MessageRow.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 11/3/24.
//

import SwiftUI

struct MessageRow: View {
    // MARK: - Properties -
    var message: String
    var time: String
    var ownMessage: Bool = false

    // MARK: - View -
    var body: some View {
        HStack {
            if ownMessage {
                Spacer(minLength: 40)
            }
            HStack {
                Text(message)
                    .padding()
                    .font(.title2)
                    .foregroundStyle(.letter)
                    .lineLimit(nil)
                    .frame(minWidth: 40,
                           minHeight: 2,
                           alignment: .leading)
                Text(time)
                    .foregroundStyle(.letter)
                    .padding(4)
            }
            .background(Color.contrast.opacity(0.2))
            .cornerRadius(20)
            .opacity(0.9)
            .fixedSize(horizontal: false,
                       vertical: true)
            if !ownMessage {
                Spacer(minLength: 40)
            }
        }
    }
}

#Preview {
    MessageRow(message: "Hello, what are you?", time: "00:10")
}
