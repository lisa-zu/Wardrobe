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
    @State private var isShowingFilterView: Bool = false
    @State private var season: WardrobeItemSeason = .autumn
    @State private var isActiveFilter: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // TOP SCROLL VIEW
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items.filter { $0.category.position == "POSITION_TOP" }) { item in
                            WardrobeItemView(item: item)
                        }
                    }
                    .scrollTargetLayout()
                }
                .containerRelativeFrame(.vertical, count: 3, spacing: 16.0)
                .contentMargins(4.0, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                
                // MIDDLE SCROLL VIEW
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items.filter { $0.category.position == "POSITION_MIDDLE" }) { item in
                            WardrobeItemView(item: item)
                        }
                    }
                    .scrollTargetLayout()
                }
                .containerRelativeFrame(.vertical, count: 3, spacing: 16.0)
                .contentMargins(4.0, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                
                // BOTTOM SCROLL VIEW
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items.filter { $0.category.position == "POSITION_BOTTOM" }) { item in
                            WardrobeItemView(item: item)
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
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.isShowingItemPickerView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.isShowingFilterView.toggle()
                    } label: {
                        Image(systemName: isActiveFilter ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $isShowingItemPickerView) {
                WardrobeItemPickerView()
            }
            .sheet(isPresented: $isShowingFilterView) {
                WardrobeFiltersView(
                    isActive: $isActiveFilter,
                    season: $season
                )
            }
        }
    }
}

#Preview {
    OutfitPickerView()
        .modelContainer(for: WardrobeItem.self)
}
