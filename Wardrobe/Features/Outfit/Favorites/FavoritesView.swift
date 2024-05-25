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
    @Query(filter: #Predicate<WardrobeItem> { movie in movie.isFavorite == true }) var favorites: [WardrobeItem]
    var dateFormatter: DateFormatter {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if favorites.isEmpty {
                    ContentUnavailableView("NO_FAVORITES", systemImage: "heart.slash", description: Text(LocalizedStringKey(stringLiteral: "NO_FAVORITES_DESCRIPTION")))
                } else {
                    ScrollView(.vertical) {
                        ForEach(favorites) { item in
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
