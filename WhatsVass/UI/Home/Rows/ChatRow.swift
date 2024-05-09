//
//  ChatRow.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 2/4/24.
//

import SwiftUI

struct ChatRow: View {
    let nick: String
    let message: String
    let avatar: String
    let sendDate: String
    let isOnline: Bool
   
    var body: some View {
        HStack(alignment:.top) {
            UserInitialCircleStatusIndicator(nick: nick, avatar: avatar, isOnLine: isOnline)
            VStack(alignment: .leading) {
                Text(nick)
                    .foregroundColor(.letter)
                    .bold()
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.letter)
            }
            Spacer()
            Text(sendDate)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

extension ChatRow {
    init(chat: Chat) {
        self.nick = chat.otherUserNick
        self.message = chat.lastMessageView
        self.sendDate = chat.showLasMesageDateInfo
        self.avatar = chat.targetavatar
        self.isOnline = chat.isOtherUserOnline
    }
}

#Preview {
    ChatRow(chat: Chat.preview)
}
