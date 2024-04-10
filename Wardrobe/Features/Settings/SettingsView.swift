//
//  SettingsView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 08.04.24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        Button(action: {
            authService.deleteAccount { error in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
            }
        }, label: {
            Text("Account löschen")
        })
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthService())
}
