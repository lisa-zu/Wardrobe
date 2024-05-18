//
//  SecondaryCancelButton.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 13.04.24.
//

import Foundation
import SwiftUI

struct SecondaryCancelButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(.gray)
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
