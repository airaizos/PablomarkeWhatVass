//
//  ContactsViewModel.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import Foundation
import Combine

final class ContactsViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var contacts: [User] = []
    @Published var contactsBySection: [String: [User]] = [:]

    private let dataManager: ContactsDataManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    private var newlyCreatedChatId: String?

    var chatSubject: PassthroughSubject<Chat, Never> = .init()

    init(dataManager: ContactsDataManagerProtocol) {
        self.dataManager = dataManager
        getContacts()
    }

    // MARK: - Public methods -
    func getContacts() {
        dataManager.getContacts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] contacts in
                //saveCodableToDocumentsDirectory(contacts, fileName: "getContacts.json")
                self?.contacts = contacts
                self?.sortContactsAlphabetically()
            })
            .store(in: &cancellables)
    }

    func createChat(with contact: User) {
        guard let sourceId = UserDefaults.standard.string(forKey: Preferences.id) else { return }

        let targetId = contact.id

        dataManager.createChat(source: sourceId, target: targetId)
            .flatMap { [weak self] chatCreateResponse -> AnyPublisher<Chat, BaseError> in
                guard chatCreateResponse.success, let self = self else {
                    return Fail(error: .generic).eraseToAnyPublisher()
                }

                self.newlyCreatedChatId = chatCreateResponse.chat.id

                return self.dataManager.getChats()
                    .receive(on: DispatchQueue.main)
                    .tryMap { chats -> Chat in
                        guard let newChat = chats.first(where: { $0.chat == chatCreateResponse.chat.id }) else {
                         
                            throw BaseError.failedChat
                        }
                        return newChat
                    }
                    .mapError { _ in .generic  }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    // print Error
                }
                self?.newlyCreatedChatId = nil
            }, receiveValue: { [weak self] newChat in
                //saveCodableToDocumentsDirectory(newChat, fileName: "newChat.json")
                self?.chatSubject.send(newChat)
            })
            .store(in: &cancellables)
    }

    func sortContactsAlphabetically() {
        contacts.sort { $0.nick.localizedCaseInsensitiveCompare($1.nick) == .orderedAscending }
        var newContactsBySection: [String: [User]] = [:]

        for contact in contacts {
            let key = String(contact.nick.prefix(1)).uppercased()
            if var users = newContactsBySection[key] {
                users.append(contact)
                newContactsBySection[key] = users
            } else {
                newContactsBySection[key] = [contact]
            }
        }

        contactsBySection = newContactsBySection
    }

    func filterContacts(searchText: String) {
        let filtered = searchText.isEmpty ? contacts
        : contacts.filter { $0.nick.localizedCaseInsensitiveContains(searchText) }
        var newContactsBySection: [String: [User]] = [:]
        for contact in filtered {
            let key = String(contact.nick.prefix(1)).uppercased()
            if var users = newContactsBySection[key] {
                users.append(contact)
                newContactsBySection[key] = users
            } else {
                newContactsBySection[key] = [contact]
            }
        }

        contactsBySection = newContactsBySection
    }
}
