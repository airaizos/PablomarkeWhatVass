//
//  SplashView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel = SplashViewModel()
    var delegate: SplashDelegate?
    var body: some View {
        VStack {
            Image(uiImage: AssetsImages.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 334)
                .padding(.top,50)
            Spacer()
            if !viewModel.isLoading {
                ProgressView(LocalizedStringKey("Loading"))
                    .tint(.white)
                    .controlSize(.extraLarge)
                    .foregroundStyle(.white)
                    .font(.title)
                Spacer()
            }
            Image(uiImage: AssetsImages.vassLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding(.bottom,30)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            LinearGradient(colors: [Color.darkDarkmode.opacity(0.5),Color.darkDarkmode.opacity(0.7),Color.darkDarkmode.opacity(0.9),Color.darkDarkmode], startPoint: .top, endPoint: .bottom)
        )
        .onAppear {
            Task {
                try await Task.sleep(for: .seconds(1.5))
                delegate?.navigateToLogin()
            }
        }
    }
}

extension SplashView {
    init(delegate: SplashDelegate?) {
        self.delegate = delegate
    }
}

#Preview {
    SplashView()
}

protocol SplashDelegate: AnyObject {
    func navigateToLogin()
}
