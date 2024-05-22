//
//  HomeView.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.

import SwiftUI

struct HomeView: View {
    // MARK: - Properties -
    @EnvironmentObject var viewModel: HomeViewModel

    // MARK: - View -
    var body: some View {
            Group {
                if viewModel.filteredChats.isEmpty {
                    NoMessageView()
                } else {
                    List {
                        ForEach(viewModel.filteredChats, id: \.chat) { chat in
                            NavigationLink(value: chat) {
                                ChatRow(chat: chat)
                                    .frame(height: 70)
                            }
                        }
                        .onDelete(perform: viewModel.deleteChat)
                    }
                }
            }
            .navigationDestination(for: Chat.self) { value in
                ChatView(viewModel: ChatViewModel(chat: value))
            }
            .searchable(text: $viewModel.searchText, prompt: "Search...")
            .alert(isPresented: $viewModel.showingDeleteError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.deleteErrorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            .sheet(isPresented: $viewModel.showContacts) {
                ContactsView() { newChat in
                    viewModel.newChat = newChat
                    viewModel.showNewChat.toggle()
                }
            }
            .sheet(isPresented: $viewModel.showSettings) {
                SettingsView()
            }
            .sheet(isPresented: $viewModel.showNewChat) {
                //Falta cabecera
                if let chat = viewModel.newChat {
                    ChatView(viewModel: ChatViewModel(chat: chat))
                }
            }
            
            .toolbar {
                settingsButton
            }
            .overlay(plusButtonOverlay)
        .onAppear {
            viewModel.getChats()
        }
    }

    private var plusButtonOverlay: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewModel.showContacts.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.dark)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .padding()
                })
            }
        }
    }

    private func didTapSettings() {
        viewModel.showSettings.toggle()
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel(dataManager: HomeDataManagerMock()))
}


struct NoMessageView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("To send messages tap the icon in the bottom corner of your screen")
                .foregroundColor(.soft)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGray6))
    }
}


extension HomeView {
    
    var settingsButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: didTapSettings) {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.dark)
            }
        }
    }
}
