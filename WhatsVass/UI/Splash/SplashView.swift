//
//  SplashView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI


struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel
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
        .vassBackground()
        .onAppear {
            Task {
                try await Task.sleep(for: .seconds(1.5))
                viewModel.navigateToLogin()
            }
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel())
}
