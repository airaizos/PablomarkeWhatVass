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
                TextField(NSLocalizedString("Write your message...",
                                            comment: ""),
                          text: $text)
                .foregroundColor(Color.darkDarkmode)
                .disableAutocorrection(true)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.darkDarkmode)
                        .background(Color.contrast.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                )
                .onChange(of: text) { _,newText in
                    buttonDisabled = newText.textIsEmpty()
                               }
            if !buttonDisabled {
                Button {
                    viewModel.sendNewMessage(message: text)
                    text = ""
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
    MessageSenderView(viewModel: ChatViewModel(dataManager: ChatDataManagerMock(), chat: .preview))
}
