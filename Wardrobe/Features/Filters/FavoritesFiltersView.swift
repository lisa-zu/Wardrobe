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
    @Binding var filterIsActive: Bool
    
    init(isActive: Binding<Bool>, season: Binding<WardrobeItemSeason>, category: Binding<WardrobeItemCategory>) {
        self._filterIsActive = isActive
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
            .scrollContentBackground(.hidden)
            .navigationTitle("FILTER")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text(LocalizedStringKey(stringLiteral: "CLOSE"))
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        season = .autumn
                        category = .top
                        self.filterIsActive = false
                    } label: {
                        Text(LocalizedStringKey(stringLiteral: "RESET"))
                            .foregroundStyle(filterIsActive ? .red : .accentColor)
                    }
                    .disabled(!filterIsActive)
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    self.filterIsActive = true
                } label: {
                    Text(LocalizedStringKey(stringLiteral: "APPLY"))
                }
                .buttonStyle(.primaryConfirmFullWidth)
            }
        }
    }
}

#Preview {
    FavoritesFiltersView(isActive: .constant(false), season: .constant(.autumn), category: .constant(.dress))
}
