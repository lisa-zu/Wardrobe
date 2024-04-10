//
//  AuthView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        ScrollViewReader { context in
            ScrollView(.horizontal) {
                HStack {
                    LoginView(scrollProxy: context)
                        .environmentObject(authService)
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0.0)
                        .id("login")
                    SignupView(scrollProxy: context)
                        .environmentObject(authService)
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0.0)
                        .id("signup")
                }
            }
            .scrollDisabled(true)
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthService())
}
