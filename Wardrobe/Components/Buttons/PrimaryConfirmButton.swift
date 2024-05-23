//
//  PrimaryConfirmButton.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 13.04.24.
//

import Foundation
import SwiftUI

struct PrimaryConfirmButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(isEnabled ? Color.wardrobePrimary.opacity(1.0) : Color.wardrobePrimary.opacity(0.55))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension ButtonStyle where Self == PrimaryConfirmButton {
    static var primaryConfirm: Self { Self() }
}
