//
//  FavoritesFiltersView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 25.05.24.
//

import SwiftUI

struct FavoritesFiltersView: View {
    
    @Environment (\.dismiss) var dismiss
    @Binding var season: WardrobeItemSeason
    @Binding var category: WardrobeItemCategory
    
    init(season: Binding<WardrobeItemSeason>, category: Binding<WardrobeItemCategory>) {
        self._season = season
        self._category = category
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("PICK_CATEGORY", selection: $category) {
                    ForEach(WardrobeItemCategory.allCases) { _category in
                        Text(LocalizedStringKey(stringLiteral: _category.rawValue))
                    }
                }
                .pickerStyle(.navigationLink)
                Picker("PICK_SEASON", selection: $season) {
                    ForEach(WardrobeItemSeason.allCases) { _season in
                        Text(LocalizedStringKey(stringLiteral: _season.rawValue))
                    }
                }
                .pickerStyle(.navigationLink)
            }
            .navigationTitle("FILTER")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text(LocalizedStringKey(stringLiteral: "CLOSE"))
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesFiltersView(season: .constant(.autumn), category: .constant(.dress))
}
