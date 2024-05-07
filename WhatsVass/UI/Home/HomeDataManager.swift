//
//  HomeDataManager.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.
//

import Foundation
import Combine

final class HomeDataManager {
    // MARK: - Properties
    private var apiClient: HomeAPIClient
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(apiClient: HomeAPIClient) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods
    func getChats() -> AnyPublisher<ChatsList, BaseError> {
        apiClient.getChats()
            .tryMap { chats in
                //saveCodableToDocumentsDirectory(chats, fileName: "ChatList.json")
                return chats
            }
            .mapError { error in
                return error as? BaseError ?? .failedChat
            }
            .eraseToAnyPublisher()
    }

    func getMessages() -> AnyPublisher<[MessageViewResponse], BaseError> {
        apiClient.getMessages()
            .tryMap { messages in
                //saveCodableToDocumentsDirectory(messages, fileName: "MessageViewResponse.json")
                return messages
            }
            .mapError { error in
                return error as? BaseError ?? .failedChat
            }
            .eraseToAnyPublisher()
    }

    func deleteChat(chatId: String) -> AnyPublisher<DeleteChatResponse, BaseError> {
        return apiClient.deleteChat(chatId: chatId)
            .tryMap { deleteChat in
                //saveCodableToDocumentsDirectory(deleteChat,fileName: "deleteChat.json")
                return deleteChat
            }
            .mapError { error in
                return error as? BaseError ?? .failedChat
            }
            .eraseToAnyPublisher()
    }
}

func saveCodableToDocumentsDirectory<T: Codable>(_ codable: T, fileName: String) {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    if let data = try? encoder.encode(codable) {
        try? data.write(to: fileURL)
        print("Archivo guardado en: \(fileURL)")
    } else {
        print("No se ha podido guardar en: \(fileURL)")
    }
}

