//
//  WardrobeApp.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import SwiftUI
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct WardrobeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authService: AuthService = AuthService()
    @StateObject private var features: FeatureFlags = FeatureFlags()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WardrobeItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
//            switch authService.userIsSignedIn {
//            case true:
//                ContentView()
//                    .environmentObject(authService)
//            case false:
//                AuthView()
//                    .environmentObject(authService)
//            }
        }
        .modelContainer(sharedModelContainer)
    }
}
