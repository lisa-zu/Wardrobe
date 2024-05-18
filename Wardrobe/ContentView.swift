//
//  ContentView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        TabView {
            SettingsView()
                .environmentObject(authService)
                .tabItem {
                    Label("TAB_SETTINGS", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthService())
}
