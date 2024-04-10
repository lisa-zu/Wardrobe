//
//  FeatureFlags.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 10.04.24.
//

import Foundation
import SwiftUI

class FeatureFlags: ObservableObject {
    
    @Published var features: Features?
    
    init() {
        self.getFeatures()
    }
    
    func getFeatures() {
        guard let path = Bundle.main.path(forResource: "Features", ofType: "plist") else {
            return
        }
        let url = URL(filePath: path)
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(Features.self, from: data)
            self.features = decodedData
        } catch {
            debugPrint("FeatureFlags >>> \(error.localizedDescription)")
        }
    }

}
