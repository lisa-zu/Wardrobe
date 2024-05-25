//
//  ContentView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        TabView {
            OutfitPickerView()
                .tabItem {
                    Label("OUTFIT_PICKER", systemImage: "eyes")
                }
            FavoritesView()
                .tabItem {
                    Label("FAVORITES", systemImage: "heart")
                }
            SettingsView()
                .environmentObject(authService)
                .tabItem {
                    Label("TAB_SETTINGS", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthService())
        .modelContainer(for: WardrobeItem.self)
}
