//
//  WardrobeItemCategory.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 19.05.24.
//

import Foundation

enum WardrobeItemCategory: String, Codable, CaseIterable, Identifiable {
    case top = "CATEGORY_TOP"
    case pants = "CATEGORY_PANTS"
    case dress = "CATEGORY_DRESS"
    case shoes = "CATEGORY_SHOES"
    
    var id: Self {
        return self
    }
    
    var position: String {
        switch self {
        case .top:
            return "POSITION_TOP"
        case .pants:
            return "POSITION_MIDDLE"
        case .dress:
            return "POSITION_MIDDLE"
        case .shoes:
            return "POSITION_BOTTOM"
        }
    }

}
