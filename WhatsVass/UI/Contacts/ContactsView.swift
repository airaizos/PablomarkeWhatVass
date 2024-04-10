//
//  ContactsView.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 14/3/24.
//

import SwiftUI

struct ContactsView: View {
    @ObservedObject var viewModel: ContactsViewModel
    @State private var searchText = ""

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
                                Button(action: {
                                    viewModel.createChat(with: contact)
                                }, label: {
                                    ContactRow(user: contact)
                                })
                            }
                        }
                    }
                }
            }
        }
        .background(Color.main)
        .onAppear {
            viewModel.getContacts()
        }
        .onChange(of: searchText) { newValue in
            viewModel.filterContacts(searchText: newValue)
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
    var user: User

    var body: some View {
        HStack(spacing: 6) {
            userInitialsCircle
            Text(user.nick)
                .bold()
                .foregroundStyle(.soft)
            Spacer()
        }
        .padding(.vertical, 8)
    }

    private var userInitialsCircle: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 60, height: 60)
            Text(String(user.nick.prefix(1)))
                .foregroundColor(.white)
                .bold()
        }
    }
}
