//
//  WardrobeItem.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 18.05.24.
//

import Foundation
import SwiftData

@Model
final class WardrobeItem {
    var name: String
    var isFavorite: Bool
    var category: WardrobeItemCategory
    var season: WardrobeItemSeason
    @Attribute(.externalStorage) var image: Data?
    var createdAt: Date
    
    init(name: String, category: WardrobeItemCategory, season: WardrobeItemSeason, image: Data? = nil, createdAt: Date = .now, isFavorite: Bool = false) {
        self.name = name
        self.category = category
        self.season = season
        self.image = image
        self.createdAt = createdAt
        self.isFavorite = isFavorite
    }
}
