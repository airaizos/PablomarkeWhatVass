//
//  ContactsView.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import SwiftUI

struct ContactsView: View {
    @Environment(\.theme) private var theme: Theme
    @EnvironmentObject var homeViewModel: HomeViewModel
    @ObservedObject var viewModel = ContactsViewModel()
    @State private var searchText = ""
    var newChat: (Chat) -> ()
    var body: some View {
        VStack {
            searchBar
            if !searchText.isEmpty && viewModel.contactsBySection.isEmpty {
                ZStack {
                    Color.init(uiColor: .systemGray6)
                    Text("No matches")
                        .bold()
                        .foregroundColor(.soft)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.contactsBySection.keys.sorted(), id: \.self) { key in
                        Section(header: Text(key)) {
                            ForEach(viewModel.contactsBySection[key] ?? [], id: \.id) { contact in
                                Button {
                                    viewModel.createChat(with: contact)
                                    
                                    if let chat = viewModel.newChat {
                                        newChat(chat)
                                        homeViewModel.showContacts.toggle()
                                      
                    //ChatView(viewModel: ChatViewModel(chat: newChat))
                                    }
                                } label: {
                                    ContactRow(user: contact)
                                }
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .background(theme.secondaryColor)
        .onAppear {
            viewModel.getContacts()
        }
        .onChange(of: searchText) { _,newValue in
            viewModel.filterContacts(searchText: newValue)
        }
        .alert(LocalizedStringKey(viewModel.errorMessage), isPresented: $viewModel.showError) {
        }
    }

    private var filteredContacts: [User] {
        if searchText.isEmpty {
            return viewModel.contacts
        } else {
            return viewModel.contacts.filter { $0.nick.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // MARK: - Subviews
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search...",
                      text: $searchText)
            .foregroundColor(Color.dark)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                })
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }
}

// MARK: - ContactRow
struct ContactRow: View {
    let nick: String
    let avatar: String
    var body: some View {
        HStack(spacing: 6) {
            UserInitialCircle(nick: nick, avatar: avatar)
            Text(nick)
                .bold()
                .foregroundStyle(.soft)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

extension ContactRow {
    init(user: User) {
        self.nick = user.nick
        self.avatar = user.avatar
    }
}

#Preview {
    NavigationStack {
        ContactsView(viewModel: ContactsViewModel(dataManager: ContactsDataManagerMock())) { _ in }
    }
}


