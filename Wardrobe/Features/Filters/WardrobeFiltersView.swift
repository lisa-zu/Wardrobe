//
//  WardrobeFiltersView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 25.05.24.
//

import SwiftUI

struct WardrobeFiltersView: View {
    
    @Environment (\.dismiss) var dismiss
    @Binding var season: WardrobeItemSeason
    
    init(season: Binding<WardrobeItemSeason>) {
        self._season = season
    }
    
    var body: some View {
        NavigationStack {
            Form {
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
    WardrobeFiltersView(season: .constant(.summer))
}
