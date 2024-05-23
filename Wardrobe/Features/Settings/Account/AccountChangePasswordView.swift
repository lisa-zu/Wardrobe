//
//  AccountChangePasswordView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 13.04.24.
//

import SwiftUI

struct AccountChangePasswordView: View {
    
    @EnvironmentObject var authService: AuthService
    @State private var currentUserPassword: String = ""
    @State private var newUserPassword: String = ""
    @State private var newUserPasswordValidation: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(authService.user?.email ?? "")
                Text("PASSWORD_CHANGE")
                    .font(.system(.title, design: .default, weight: .bold))
                Text("PASSWORD_CHANGE_MESSAGE")
                VStack {
//                    HStack {
//                        Image(systemName: "exclamationmark.lock")
//                            .foregroundStyle(Color.wardrobePrimary)
//                            .frame(width: 32)
//                        SecureField("PASSWORD_CURRENT", text: $currentUserPassword)
//                            .font(.system(.callout))
//                    }
//                    .padding()
//                    .background {
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color.clear)
//                            .stroke(Color.wardrobeSecondary, lineWidth: 1.0)
//                    }
                    HStack {
                        Image(systemName: "exclamationmark.lock")
                            .foregroundStyle(Color.wardrobePrimary)
                            .frame(width: 32)
                        SecureField("PASSWORD_NEW", text: $newUserPassword)
                            .font(.system(.callout))
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
                        SecureField("PASSWORD_NEW_VALIDATION", text: $newUserPasswordValidation)
                            .font(.system(.callout))
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.clear)
                            .stroke(Color.wardrobeSecondary, lineWidth: 1.0)
                    }
                }
                Button(action: {
                    authService.requestPasswordReset { error in
                        if let error = error {
                            debugPrint(error.localizedDescription)
                        }
                    }
                }, label: {
                    Text("PASSWORD_FORGOT")
                        .font(.system(.caption, design: .rounded, weight: .regular))
                })
                Spacer()
                Button(action: {
                    authService.updateUserPassword(to: newUserPassword) { error in
                        if let error = error {
                            debugPrint(error.localizedDescription)
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Text("PASSWORD_CHANGE")
                        Spacer()
                    }
                })
                .buttonStyle(.primaryConfirm)
                .disabled(validateNewPasswordInput())
            }
            .padding()
        }
    }
    
    private func validateNewPasswordInput() -> Bool {
        if newUserPassword == "" || newUserPasswordValidation == "" {
            return true
        } else {
            return !(newUserPassword == newUserPasswordValidation)
        }
    }
    
}

#Preview {
    AccountChangePasswordView()
        .environmentObject(AuthService())
}
