//
//  HomeView.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 8/3/24.

import SwiftUI
import Combine

struct HomeView: View {
    // MARK: - Properties -
    @ObservedObject var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View -
    var body: some View {
        NavigationView {
            Group {
                if viewModel.filteredChats.isEmpty {
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
                } else {
                    List {
                        ForEach(viewModel.filteredChats, id: \.chat) { chat in
                            Button(action: {
                                viewModel.onChatSelected(chat)
                            }, label: {
                                ChatRow(chat: chat)
                                    .frame(height: 70)
                            })
                        }
                        .onDelete(perform: viewModel.deleteChat)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search...")
            .alert(isPresented: $viewModel.showingDeleteError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.deleteErrorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .toolbar {
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
            .overlay(plusButtonOverlay)
        }
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
                    viewModel.onNewChatSelected()
                }, label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.dark)
                        .foregroundColor(Color.contrast)
                        .clipShape(Circle())
                        .padding()
                })
            }
        }
    }

    private func didTapSettings() {
        viewModel.navigateToSettings()
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(dataManager: HomeDataManagerMock()))
}
