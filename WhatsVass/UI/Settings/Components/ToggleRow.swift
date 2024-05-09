//
//  ToggleRow.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 9/5/24.
//

import SwiftUI

struct ToggleRow: View {
    @Binding var isOn: Bool
    var title: String
    var action: () -> ()
    var body: some View {
        LabeledContent {
            VassToggle(isOn: $isOn) {
                action()
            }
        } label: {
            Text(LocalizedStringKey(title))
                .font(.title)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ToggleRow(isOn: .constant(true), title: "Notifications") { }
}
