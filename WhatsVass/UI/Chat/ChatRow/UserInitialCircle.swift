//
//  UserInitialCircle.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct UserInitialCircle:View {
    let nick: String
    let avatarURL: URL?
    var width: Double = 60
    var body: some View {
                AsyncImage(url: avatarURL) { avatar in
                    avatar
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 5,x:3,y:3)
                        .clipShape(Circle())
                        .frame(width: width)
                } placeholder: {
                    Circle()
                        .fill(Color.gray)
                        .shadow(radius: 5,x:3,y:3)
                        .frame(width: width)
                        .overlay(
                            Text(String(nick.prefix(1)))
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                        )
        }
    }
}

extension UserInitialCircle {
    init(nick:String, avatar: String) {
        self.nick = nick
        self.avatarURL = URL(string:avatar)
    }
}

#Preview {
    UserInitialCircle(nick: "User", avatar: "https://api.dicebear.com/8.x/adventurer/png?seed=Ramen")
}
