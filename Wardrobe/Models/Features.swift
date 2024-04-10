//
//  Features.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 10.04.24.
//

import Foundation

struct Features: Codable {
    var loginRequired: Bool
    
    enum CodingKeys: String, CodingKey {
        case loginRequired = "LOGIN_REQUIRED"
    }
}
