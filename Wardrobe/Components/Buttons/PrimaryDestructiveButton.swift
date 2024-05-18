//
//  PrimaryDestructiveButton.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 13.04.24.
//

import Foundation
import SwiftUI

struct PrimaryDestructiveButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(isEnabled ? .red.opacity(1.0) : .red.opacity(0.75))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
