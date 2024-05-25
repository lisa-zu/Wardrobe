//
//  WardrobeItemView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 24.05.24.
//

import SwiftUI
import SwiftData

struct WardrobeItemView: View {
    
    let item: WardrobeItem
    @Environment(\.modelContext) private var modelContext
    @State private var showItemActions: Bool = false
    
    var actionButtons: some View {
        HStack {
            Button {
                item.isFavorite.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.linear(duration: 0.4)) {
                        showItemActions = false
                    }
                }
            } label: {
                Image(systemName: item.isFavorite ? "heart.fill": "heart")
                    .padding()
                    .foregroundStyle(.regularMaterial)
                    .background(.regularMaterial, in: Circle())
            }
            Button {
                modelContext.delete(item)
            } label: {
                Image(systemName: "trash")
                    .padding()
                    .foregroundStyle(.regularMaterial)
                    .background(.regularMaterial, in: Circle())
            }
        }
    }
    
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
            .onLongPressGesture {
                withAnimation(.linear(duration: 0.4)) {
                    showItemActions.toggle()
                }
            }
            .overlay {
                if showItemActions {
                    actionButtons
                } else {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthService())
        .modelContainer(for: WardrobeItem.self)
}
