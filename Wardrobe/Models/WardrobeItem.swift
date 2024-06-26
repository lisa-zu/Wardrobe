//
//  WardrobeItem.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 18.05.24.
//

import Foundation
import SwiftUI
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
    
    init(name: String, category: WardrobeItemCategory, season: WardrobeItemSeason, image: UIImage, createdAt: Date = .now, isFavorite: Bool = false) {
        self.name = name
        self.category = category
        self.season = season
        self.image = image.pngData()
        self.createdAt = createdAt
        self.isFavorite = isFavorite
    }
}

extension WardrobeItem {
    public func toggleFavorite() {
        self.isFavorite.toggle()
    }
}

extension WardrobeItem {
    static var exampleWithImage: WardrobeItem {
        let image: UIImage = UIImage(named: "BANDEAU") ?? UIImage()
        return WardrobeItem(name: "BANDEAU", category: .top, season: .summer, image: image)
    }
    static var exampleFavoriteWithImage: WardrobeItem {
        let image: UIImage = UIImage(named: "BANDEAU") ?? UIImage()
        return WardrobeItem(name: "BANDEAU", category: .top, season: .summer, image: image, isFavorite: true)
    }
}
