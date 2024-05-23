//
//  WardrobeError.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 19.05.24.
//

import Foundation

enum WardrobeError: LocalizedError {
    case unknown
    case storage
    
    public var localizedDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("ERROR_UNKNOWN", comment: "SORRY")
        case .storage:
            return NSLocalizedString("ERROR_STORAGE", comment: "SORRY")
        }
    }
}
