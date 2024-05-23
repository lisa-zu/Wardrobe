//
//  PrimaryConfirmButtonFullWidth.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 13.04.24.
//

import Foundation
import SwiftUI

struct PrimaryConfirmButtonFullWidth: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
            Spacer()
        }
        .background(isEnabled ? Color.wardrobePrimary.opacity(1.0) : Color.wardrobePrimary.opacity(0.55), in: RoundedRectangle(cornerRadius: 16))
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}

extension ButtonStyle where Self == PrimaryConfirmButtonFullWidth {
    static var primaryConfirmFullWidth: Self { Self() }
}
