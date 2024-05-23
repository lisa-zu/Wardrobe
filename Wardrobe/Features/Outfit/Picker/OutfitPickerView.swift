//
//  OutfitPickerView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 18.05.24.
//

import SwiftUI
import SwiftData

struct OutfitPickerView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [WardrobeItem]
    @State private var isShowingItemPickerView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items.filter { $0.category.position == "POSITION_TOP" }) { item in
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
                    .scrollTargetLayout()
                }
                .containerRelativeFrame(.vertical, count: 3, spacing: 16.0)
                .contentMargins(4.0, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items.filter { $0.category.position == "POSITION_MIDDLE" }) { item in
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
                    .scrollTargetLayout()
                }
                .containerRelativeFrame(.vertical, count: 3, spacing: 16.0)
                .contentMargins(4.0, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items.filter { $0.category.position == "POSITION_BOTTOM" }) { item in
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
                    .scrollTargetLayout()
                }
                .containerRelativeFrame(.vertical, count: 3, spacing: 16.0)
                .contentMargins(4.0, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.isShowingItemPickerView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingItemPickerView) {
                WardrobeItemPickerView()
            }
        }
    }
}

#Preview {
    OutfitPickerView()
        .modelContainer(for: WardrobeItem.self)
}
