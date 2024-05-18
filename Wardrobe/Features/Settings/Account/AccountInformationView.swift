//
//  AccountInformationView.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 13.04.24.
//

import SwiftUI

struct AccountInformationView: View {
    
    @EnvironmentObject var authService: AuthService
    @State private var showingAccountDeletionAlert = false
    @State private var userPassword: String = ""
    @State private var showingUserPassword: Bool = false
    @State private var showingAccountLogoutAlert = false
    @State private var showingAccountLoginSheet = false
    
    var body: some View {
        if authService.user == nil {
            ContentUnavailableView(label: {
                Label("NO_USER", systemImage: "exclamationmark.triangle")
            }, description: {
                Text(LocalizedStringKey(stringLiteral: "NO_USER_DESCRIPTION"))
            }, actions: {
                Button {
                    self.showingAccountLoginSheet.toggle()
                } label: {
                    Text("LOGIN")
                }
            })
            .fullScreenCover(isPresented: $showingAccountLoginSheet) {
                NavigationStack {
                    AuthView()
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    self.showingAccountLoginSheet.toggle()
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                }
            }
        } else {
            NavigationStack {
                Form {
                    LabeledContent {
                        Text(authService.user?.email ?? "NO_EMAIL")
                    } label: {
                        HStack {
                            Image(systemName: "mail")
                            Text("EMAIL")
                        }
                    }
                    NavigationLink {
                        AccountChangePasswordView()
                            .environmentObject(authService)
                    } label: {
                        HStack {
                            Image(systemName: "person.badge.key")
                            Text("SETTINGS_PASSWORD_CHANGE")
                        }
                    }
                    NavigationLink {
                        AccountDeletionView()
                            .environmentObject(authService)
                    } label: {
                        HStack {
                            Image(systemName: "person.badge.minus")
                            Text("DELETE_ACCOUNT")
                        }
                    }
                }
                .navigationTitle("SETTINGS_ACCOUNT")
                .fullScreenCover(isPresented: $showingAccountLogoutAlert, content: {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(LocalizedStringKey(stringLiteral: "WARNING"))
                                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                Text(LocalizedStringKey(stringLiteral: "LOGOUT_MESSAGE"))
                                    .font(.system(.body, design: .rounded, weight: .regular))
                            }
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            
                            Button(role: .cancel) {
                                showingAccountLogoutAlert.toggle()
                            } label: {
                                Text(LocalizedStringKey(stringLiteral: "CANCEL"))
                                    .padding(.horizontal)
                            }
                            .padding()
                            .foregroundStyle(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .background(.ultraThinMaterial)
                            }
                            
                            Button(action: {
                                self.initAccountLogout()
                            }, label: {
                                Text(LocalizedStringKey(stringLiteral: "YES"))
                                    .padding(.horizontal)
                            })
                            .padding()
                            .foregroundStyle(.red)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .background(.ultraThinMaterial)
                            }
                            
                            
                        }
                    }
                    .padding()
                    .presentationBackground(.ultraThinMaterial)
                })
            }
        }
    }
    
    private func initAccountLogout() {
        authService.logoutEPAccount { error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

#Preview {
    AccountInformationView()
        .environmentObject(AuthService())
}
