//
//  WardrobeItemView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 24.05.24.
//

import SwiftUI

struct WardrobeItemView: View {
    
    let item: WardrobeItem
    
    var body: some View {
        if let imageData = item.image {
            VStack {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(item.name)
            }
            .containerRelativeFrame(.horizontal, count: 1, spacing: 16.0)
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1.0 : 0.2)
                    .scaleEffect(
                        x: phase.isIdentity ? 1.0 : 0.75,
                        y: phase.isIdentity ? 1.0 : 0.75
                    )
                    .offset(y: phase.isIdentity ? 0 : 50)
            }
        }
    }
}
