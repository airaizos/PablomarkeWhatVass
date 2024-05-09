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
            HStack(alignment:.top) {
                Text(message)
                    .padding(.horizontal, 15)
                    .padding(.vertical,10)
                    .foregroundStyle(.letter)
                    .frame(minWidth: 40,
                           minHeight: 2,
                           alignment: ownMessage ? .leading : .trailing)
                Text(time)
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .padding(10)
            }
            .background(ownMessage ? Color.contrast.opacity(0.2) : .gray.opacity(0.3))
            .cornerRadius(8)
            .opacity(0.9)
            .fixedSize(horizontal: false,
                       vertical: true)
        }
    }
}

extension MessageRow {
    init(row: RowMessage) {
        self.message = row.message
        self.time = row.dateTime.messageDateView
        self.ownMessage = row.isMine
    }
}

#Preview {
    VStack {
        HStack {
            MessageRow(message: "Hello, what are you?", time: "00:10",ownMessage: true)
            Spacer()
        }
        HStack {
            Spacer()
        MessageRow(message: "Hello, what are you?", time: "00:12",ownMessage: false)
           
        }
        HStack {
        MessageRow(message: "Hello?", time: "00:14",ownMessage: true)
            Spacer()
        }
        HStack {
            Spacer()
            MessageRow(message: "Helloooo?", time: "00:16",ownMessage: false)
        }
    }
    .padding()
}
