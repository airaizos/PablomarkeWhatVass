//
//  MessageSenderView.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 12/3/24.
//

import SwiftUI

// MARK: - TextField to send messages -
struct MessageSenderView: View {
    @State private var text: String = ""
    @ObservedObject var viewModel: ChatViewModel
    @State var buttonDisabled: Bool = true

    var body: some View {
        HStack {
                TextField(LocalizedStringKey("Write your message..."),
                          text: $text)
                .foregroundColor(Color.darkDarkmode)
                .disableAutocorrection(true)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.darkDarkmode,lineWidth: 4)
                        .background(Color.contrast.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                )
                .onChange(of: text) { _,newText in
                    buttonDisabled = newText.textIsEmpty()
                               }
            if !buttonDisabled {
                Button {
                    Task {
                        await viewModel.sendNewMessage(message: text)
                        text = ""
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title)
                        .foregroundColor(Color.darkDarkmode)
                }
            }
        }
    }
}

#Preview {
    VStack {
        MessageSenderView(viewModel: ChatViewModel(dataManager: ChatDataManagerMock(), chat: .preview))
        
        MessageSenderView(viewModel: ChatViewModel(dataManager: ChatDataManagerMock(), chat: .preview),buttonDisabled: false)
    }
    .padding()
}
