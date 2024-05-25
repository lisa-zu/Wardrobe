//
//  WardrobeFiltersView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 25.05.24.
//

import SwiftUI

struct WardrobeFiltersView: View {
    
    let filterType: FilterType
    
    init(for type: FilterType) {
        self.filterType = type
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch filterType {
                case .wardrobe:
                    wardrobeFilter
                case .favorites:
                    favoritesFilter
                }
            }
            .navigationTitle("FILTER")
        }
    }
    
    var wardrobeFilter: some View {
        Form {
            
        }
    }
    
    var favoritesFilter: some View {
        Form {}
    }
}

#Preview {
    WardrobeFiltersView(for: .favorites)
}
