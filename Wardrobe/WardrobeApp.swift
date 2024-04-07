//
//  WardrobeApp.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import SwiftUI
import FirebaseCore

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
    var body: some Scene {
        WindowGroup {
            switch authService.userIsSignedIn {
            case true:
                ContentView()
                    .environmentObject(authService)
            case false:
                AuthView()
                    .environmentObject(authService)
            }
        }
    }
}
