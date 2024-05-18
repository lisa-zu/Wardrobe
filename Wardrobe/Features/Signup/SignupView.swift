//
//  SignupView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject private var viewModel: SignupViewModel = SignupViewModel()
    @EnvironmentObject var authService: AuthService
    @State private var mail: String = ""
    @State private var password: String = ""
    @State private var passwordValid: String = ""
    
    var scrollProxy: ScrollViewProxy
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(LocalizedStringKey(stringLiteral: "SIGNUP_TITLE_1"))
                    Text(LocalizedStringKey(stringLiteral: "SIGNUP_TITLE_2"))
                        .foregroundStyle(Color.wardrobePrimary)
                }
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text(LocalizedStringKey(stringLiteral: "SIGNUP_GREETING_MESSAGE"))
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
                
                if viewModel.mailIsValid != nil && !viewModel.mailIsValid! {
                    Text(LocalizedStringKey(stringLiteral: "INVALID_EMAIL"))
                }
                
                HStack {
                    Image(systemName: "exclamationmark.lock")
                        .foregroundStyle(Color.wardrobePrimary)
                        .frame(width: 32)
                    SecureField("SIGNUP_PASSWORD_PLACEHOLDER", text: $password)
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
                    SecureField("SIGNUP_PASSWORD_VALIDATE_PLACEHOLDER", text: $passwordValid)
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
                authService.createEPAccount(email: mail, password: password) { result in
                    switch result {
                    case .success( _):
                        // do something?
                        break
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    }
                }
            }, label: {
                HStack {
                    Spacer()
                    Text(LocalizedStringKey(stringLiteral: "SIGNUP"))
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
            .disabled(viewModel.signUpDisalbed)
            .padding(.bottom, 32)
            
            HStack {
                Text(LocalizedStringKey(stringLiteral: "SIGNUP_LOGIN_MESSAGE"))
                    .font(.system(.callout, design: .rounded, weight: .regular))
                Button(action: {
                    withAnimation {
                        scrollProxy.scrollTo("login")
                    }
                }, label: {
                    Text(LocalizedStringKey(stringLiteral: "SIGNUP_LOGIN_BUTTON"))
                        .font(.system(.callout, design: .rounded, weight: .regular))
                })
            }
            
            Spacer()
            
        }
        .padding()
        .onChange(of: password) { oldValue, newValue in
            viewModel.isEqualPassword(password, check: passwordValid)
            viewModel.validateSignupForm()
        }
        .onChange(of: passwordValid) { oldValue, newValue in
            viewModel.isEqualPassword(password, check: passwordValid)
            viewModel.validateSignupForm()
        }
        .onChange(of: mail) { oldValue, newValue in
            viewModel.isValidEmail(mail)
            viewModel.validateSignupForm()
        }
    }
}

#Preview {
    ScrollViewReader { context in
        SignupView(scrollProxy: context)
    }
}
