//
//  ChatRow.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 2/4/24.
//

import SwiftUI

struct ChatRow: View {
    var chat: Chat
    private let myID = UserDefaults.standard.string(forKey: Preferences.id) ?? "defaultID"

    var body: some View {
        HStack {
            userStatusIndicator
            VStack(alignment: .leading) {
                Text(otherUserNick)
                    .foregroundColor(.letter)
                    .bold()
                Text(chat.lastMessage ?? "")
                    .foregroundColor(.letter)
            }
            Spacer()
            Text(chat.lastMessageTime?.fakeDateToString() ?? "")
                .foregroundColor(.letter)
        }
        .padding(.vertical,
                 8)
    }

    private var userStatusIndicator: some View {
        ZStack(alignment: .bottomTrailing) {
            Circle()
                .fill(Color.gray)
                .frame(width: 50,
                       height: 50)
                .overlay(Text(otherUserNick.prefix(1))
                    .foregroundColor(.white))
            Circle()
                .fill(isOtherUserOnline ? Color.green : Color.red)
                .frame(width: 15,
                       height: 15)
                .offset(x: 0,
                        y: 0)
        }
    }

    private var isOtherUserOnline: Bool {
        chat.source == myID ? chat.targetonline : chat.sourceonline
    }

    private var otherUserNick: String {
        chat.source == myID ? chat.targetnick : chat.sourcenick
    }
}

#Preview {
    ChatRow(chat: Chat.preview)
}
