//
//  SettingsView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 08.04.24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authService: AuthService
    @State private var showingAccountLogoutAlert = false
    @State private var showingAccountLoginSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        Section("SETTINGS_GENERAL") {
                            NavigationLink("SETTINGS_ACCOUNT") {
                                AccountInformationView()
                                    .environmentObject(authService)
                            }
                            NavigationLink("SETTINGS_DATA") {
                                DataUsageSettingsView()
                            }
                            NavigationLink("SETTINGS_APPEARANCE") {
                                AppearanceSettingsView()
                            }
                            NavigationLink("SETTINGS_NOTIFICATION") {
                                NotificationsSettingsView()
                            }
                        }
                    }
                }
                .navigationTitle("SETTINGS_TITLE")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthService())
}
