//
//  ContactsViewModel.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import SwiftUI

final class ContactsViewModel: ObservableObject {
    @AppStorage(Preferences.id.rawValue) var sourceId = ""
    // MARK: - Properties -
    @Published var contacts: [User] = []
    @Published var contactsBySection: [String: [User]] = [:]
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isNewChatSelected = false
    @Published var newChat: Chat?

    private let dataManager: ContactsDataManagerProtocol
    private var newlyCreatedChatId: String?
    
    init(dataManager: ContactsDataManagerProtocol = ContactsDataManager()) {
        self.dataManager = dataManager
        Task {
           await getContacts()
        }
    }

    // MARK: - Public methods -
    @MainActor
    func getContacts() {
        Task {
            do {
                contacts = try await dataManager.getContacts()
                sortContactsAlphabetically()
            } catch let error {
                showError.toggle()
                
                if let error = error as? BaseError {
                    errorMessage = error.description()
                } else {
                    errorMessage = "An error occurred while retrieving contacts"
                }
            }
        }
    }

    @MainActor
    func createChat(with contact: User) {
        Task {
//            guard let sourceId = UserDefaults.standard.string(forKey: Preferences.id.rawValue) else { return }
            let targetId = contact.id
            do {
                let chatCreateResponse = try await dataManager.createChat(source: sourceId, target: targetId)
                newlyCreatedChatId = chatCreateResponse.chat.id
                
                let chats = try await dataManager.getChats()
                
                guard let newChat = chats.first(where: { $0.chat == chatCreateResponse.chat.id }) else {
                    throw BaseError.failedChat
                }
                self.newChat = newChat
                //Notification
                isNewChatSelected.toggle()
                
            } catch {
                showError.toggle()
                if let error = error as? BaseError {
                    errorMessage = error.description()
                } else {
                    errorMessage = "An error occurred while creanting a chat"
                }
            }
        }
    }
    
    func sortContactsAlphabetically() {
       contacts.sort { $0.nickname.localizedCaseInsensitiveCompare($1.nickname) == .orderedAscending }
       contactsBySection = contactsByFirstLetter(contacts)
    }

    func filterContacts(searchText: String) {
       let filtered = searchText.isEmpty ? contacts
        : contacts.filter { $0.nickname.localizedCaseInsensitiveContains(searchText) }

        contactsBySection = contactsByFirstLetter(filtered)
    }
    
    private func contactsByFirstLetter(_ contacts: [User]) -> [String: [User]] {
      contacts.reduce(into: [:]) { result, contact in
            let key = String(contact.nickname.prefix(1)).uppercased()
            result[key, default: []].append(contact)
        }
    }
}
