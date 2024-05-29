//
//  SplashView.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI


struct SplashView: View {
    @Environment(\.theme) private var theme: Theme
    @State var isLoading = false
    @Binding var navState: NavState
    var body: some View {
        VStack {
            Image(uiImage: AssetsImages.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 334)
                .padding(.top,50)
            Spacer()
            if !isLoading {
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
        .vassBackground(theme)
        .onAppear {
            Task {
                try await Task.sleep(for: .seconds(0.7))
                navState = .login
            }
        }
    }
}

#Preview {
    SplashView(navState: .constant(.splash))
}
