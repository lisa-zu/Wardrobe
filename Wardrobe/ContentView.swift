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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
                authService.logoutEPAccount { error in
                    debugPrint(error?.localizedDescription)
                }
            }, label: {
                Text("LOGOUT")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
