//
//  LoginView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authService: AuthService
    @State private var mail: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(LocalizedStringKey(stringLiteral: "LOGIN_TITLE_1"))
                    Text(LocalizedStringKey(stringLiteral: "LOGIN_TITLE_2"))
                        .foregroundStyle(Color(red: 221/255, green: 43/255, blue: 133/255))
                }
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                Spacer()
            }
            .padding(.bottom)
            
            Text(LocalizedStringKey(stringLiteral: "LOGIN_GREETING_MESSAGE"))
                .font(.system(.callout, design: .rounded, weight: .regular))
            Group {
                TextField("LOGIN_MAIL_PLACEHOLDER", text: $mail)
                    .keyboardType(.emailAddress)
                SecureField("LOGIN_PASSWORD_PLACEHOLDER", text: $password)
            }
            
            Button(action: {
                authService.loginEPAccount(email: mail, password: password) { result in
                    switch result {
                    case .success(let user):
                        // do something?
                        break
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    }
                }
            }, label: {
                Text(LocalizedStringKey(stringLiteral: "LOGIN"))
            })
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
