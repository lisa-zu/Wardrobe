//
//  AccountDeletionView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 13.04.24.
//

import SwiftUI

struct AccountDeletionView: View {
    
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var authService: AuthService
    @State private var userAccountEmailValidation: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(LocalizedStringKey(stringLiteral: "DELETION_MESSAGE"))
                    .font(.system(.body, design: .rounded, weight: .regular))
                .padding(.bottom, 32)
                Text("DELETION_VALIDATION_INPUT_MESSAGE")
                    .font(.system(.body, design: .rounded, weight: .regular))
                HStack {
                    Image(systemName: "envelope.badge.shield.half.filled")
                        .foregroundStyle(Color.wardrobePrimary)
                        .frame(width: 32)
                    TextField("EMAIL_VALIDATION", text: $userAccountEmailValidation)
                        .font(.system(.callout))
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.clear)
                        .stroke(Color.wardrobeSecondary, lineWidth: 1.0)
                }
                Spacer()
                HStack {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text(LocalizedStringKey(stringLiteral: "CANCEL"))
                            .padding(.horizontal)
                    }
                    .buttonStyle(SecondaryCancelButton())
                    Spacer()
                    Button(action: {
                        self.initAccountDeletion()
                    }, label: {
                        Text(LocalizedStringKey(stringLiteral: "YES"))
                            .padding(.horizontal)
                    })
                    .buttonStyle(PrimaryDestructiveButton())
                    .disabled(!validateUserEmail())
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("DELETE_ACCOUNT")
            .toolbar(.hidden, for: .tabBar)
        }
    }
    
    private func validateUserEmail() -> Bool {
        if let currentUserMail = authService.user?.email {
            return currentUserMail == userAccountEmailValidation
        }
        return false
    }
    
    private func initAccountDeletion() {
        authService.deleteAccount { error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}

#Preview {
    AccountDeletionView()
        .environmentObject(AuthService())
}
