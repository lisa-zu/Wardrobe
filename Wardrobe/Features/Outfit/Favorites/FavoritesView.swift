//
//  FavoritesView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 24.05.24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<WardrobeItem> { item in
        item.isFavorite == true
    }) var favorites: [WardrobeItem]
    var dateFormatter: DateFormatter {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    @State private var season: WardrobeItemSeason = .autumn
    @State private var category: WardrobeItemCategory = .top
    @State private var isActiveFilter: Bool = false
    @State private var isShowingFilterView: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if favorites.isEmpty {
                    ContentUnavailableView("NO_FAVORITES", systemImage: "heart.slash", description: Text(LocalizedStringKey(stringLiteral: "NO_FAVORITES_DESCRIPTION")))
                } else {
                    ScrollView(.vertical) {
                        ForEach(isActiveFilter ? filterFavorites(favorites) : favorites) { item in
                            GroupBox {
                                HStack {
                                    if let imageData = item.image {
                                        Image(uiImage: UIImage(data: imageData) ?? UIImage())
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxHeight: 100)
                                            .padding(.trailing, 8)
                                    }
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(item.name)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                            Spacer()
                                            Button {
                                                item.toggleFavorite()
                                            } label: {
                                                Image(systemName: "heart.slash")
                                            }
                                        }
                                        HStack {
                                            Text(LocalizedStringKey(stringLiteral: item.category.rawValue))
                                            Text("·")
                                            Text(LocalizedStringKey(stringLiteral: item.season.rawValue))
                                        }
                                        Spacer()
                                        Text("\(dateFormatter.string(from: item.createdAt))")
                                    }
                                    .font(.caption)
                                    .padding(.vertical, 8)
                                    Spacer()
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("FAVORITES")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.isShowingFilterView.toggle()
                    } label: {
                        Image(systemName: isActiveFilter ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $isShowingFilterView) {
                FavoritesFiltersView(
                    isActive: $isActiveFilter,
                    season: $season,
                    category: $category
                )
            }
        }
    }
    
    private func filterFavorites(_ items: [WardrobeItem]) -> [WardrobeItem] {
        return items.filter {
            let seasonMatches = (season == .all) || ($0.season == season)
            let categoryMatches = (category == .all) || ($0.category == category)
            return seasonMatches && categoryMatches
        }
    }
}

#Preview {
    do {
        let schema: Schema = Schema([WardrobeItem.self])
        let modelConfiguration: ModelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let modelContainer: ModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        try modelContainer.mainContext.delete(model: WardrobeItem.self)
        try modelContainer.mainContext.insert(WardrobeItem.exampleFavoriteWithImage)
        return FavoritesView()
            .modelContainer(modelContainer)
    } catch {
        return Text(error.localizedDescription)
    }
}
