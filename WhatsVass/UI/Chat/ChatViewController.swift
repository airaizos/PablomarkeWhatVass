//
//  ChatViewController.swift
//  WhatsVass
//
//  Created by Juan Carlos Torrejon Cañedo on 21/3/24.
//

import UIKit
import SwiftUI
import IQKeyboardManagerSwift

final class ChatViewController: UIHostingController<ChatView> {
    private let viewModel: ChatViewModel

    // MARK: - Init
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(rootView: ChatView(viewModel: viewModel))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
}
