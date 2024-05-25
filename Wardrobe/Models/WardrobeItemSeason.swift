//
//  WardrobeItemSeason.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 19.05.24.
//

import Foundation

enum WardrobeItemSeason: String, Codable, CaseIterable, Identifiable {
    case all = "SEASON_ALL"
    case spring = "SEASON_SPRING"
    case summer = "SEASON_SUMMER"
    case autumn = "SEASON_AUTUMN"
    case winter = "SEASON_WINTER"
    
    var id: Self { return self }
}
