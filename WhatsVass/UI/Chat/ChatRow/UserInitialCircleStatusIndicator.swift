//
//  UserInitialCircleStatusIndicator.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct UserInitialCircleStatusIndicator:View {
    let nick: String
    let avatar: String
    let isOnLine: Bool
    var width: Double = 60
    var body: some View {
        ZStack(alignment:.bottomTrailing) {
            UserInitialCircle(nick: nick, avatar: avatar)
            Circle()
                .fill(isOnLine ? Color.green : Color.red)
                .frame(width: 15, height: 15)
        }
    }
}

extension UserInitialCircleStatusIndicator {
    init(user: User, width: Double = 60) {
        self.nick = user.nickname
        self.avatar = user.avatar
        self.isOnLine = user.onLine
        self.width = width
    }
}

#Preview {
    VStack {
        UserInitialCircleStatusIndicator(nick: "User", avatar: "https://api.dicebear.com/8.x/micah/png", isOnLine: true)
        UserInitialCircleStatusIndicator(nick: "User", avatar: "https://api.dicebear.com/8.x/micah/png", isOnLine: false)
        UserInitialCircleStatusIndicator(nick: "Nick", avatar: "", isOnLine: true)
        UserInitialCircleStatusIndicator(nick: "Nick", avatar: "", isOnLine: false)
    }
}
