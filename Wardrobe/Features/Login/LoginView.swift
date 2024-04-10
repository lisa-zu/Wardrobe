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
    var scrollProxy: ScrollViewProxy
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(LocalizedStringKey(stringLiteral: "LOGIN_TITLE_1"))
                    Text(LocalizedStringKey(stringLiteral: "LOGIN_TITLE_2"))
                        .foregroundStyle(Color.wardrobePrimary)
                }
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text(LocalizedStringKey(stringLiteral: "LOGIN_GREETING_MESSAGE"))
                    .font(.system(.callout, design: .rounded, weight: .regular))
                    .foregroundStyle(Color.wardrobeSecondary)
                Spacer()
            }
            
            VStack {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundStyle(Color.wardrobePrimary)
                        .frame(width: 32)
                    TextField("LOGIN_MAIL_PLACEHOLDER", text: $mail)
                        .keyboardType(.emailAddress)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.clear)
                        .stroke(Color.wardrobeSecondary, lineWidth: 1.0)
                }
                
                HStack {
                    Image(systemName: "exclamationmark.lock")
                        .foregroundStyle(Color.wardrobePrimary)
                        .frame(width: 32)
                    SecureField("LOGIN_PASSWORD_PLACEHOLDER", text: $password)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.clear)
                        .stroke(Color.wardrobeSecondary, lineWidth: 1.0)
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 32)
            
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
                HStack {
                    Spacer()
                    Text(LocalizedStringKey(stringLiteral: "LOGIN"))
                    Spacer()
                }
            })
            .buttonStyle(.plain)
            .padding()
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.wardrobePrimary)
            }
            .padding(.bottom, 32)
            
            HStack {
                Text(LocalizedStringKey(stringLiteral: "LOGIN_SIGNUP_MESSAGE"))
                    .font(.system(.callout, design: .rounded, weight: .regular))
                Button(action: {
                    withAnimation {
                        scrollProxy.scrollTo("signup")
                    }
                }, label: {
                    Text(LocalizedStringKey(stringLiteral: "LOGIN_SIGNUP_BUTTON"))
                        .font(.system(.callout, design: .rounded, weight: .regular))
                })
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ScrollViewReader { context in
        LoginView(scrollProxy: context)
    }
}
