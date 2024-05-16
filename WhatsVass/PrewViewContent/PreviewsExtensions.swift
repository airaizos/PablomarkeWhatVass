//
//  PreviewsExtensions.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 16/5/24.
//

import Foundation


extension ChatViewModel {
    static let preview = ChatViewModel(dataManager: ChatDataManagerMock(), chat: Chat.preview)
}

extension SettingsViewModel {
    static let preview = SettingsViewModel(dataManager: SettingsDataManagerMock(), secure: KeychainMock(), persistence: MockPersistence(), notificationCenter: NotificationCenter.default)
}
