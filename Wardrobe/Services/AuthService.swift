//
//  AuthService.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import Foundation
import FirebaseAuth

class AuthService: ObservableObject {
    @Published var userIsSignedIn: Bool = false
    @Published var user: User? = nil
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let loggedInUser = user {
                self.userIsSignedIn = true
                self.user = User(name: loggedInUser.displayName, email: loggedInUser.email)
            } else {
                self.userIsSignedIn = false
            }
        }
    }
}

extension AuthService {
    func createEPAccount(email: String, password: String, completion: @escaping((Result<User, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            if let user = authResult?.user {
                completion(.success(User(name: user.displayName, email: user.email)))
            }
        }
    }
    func loginEPAccount(email: String, password: String, completion: @escaping((Result<User, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            if let user = authResult?.user {
                completion(.success(User(name: user.displayName, email: user.email)))
            }
        }
    }
    func logoutEPAccount(completion: @escaping((Error?) -> Void)) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let signOutError as NSError {
            completion(signOutError)
        }
    }
    func deleteAccount(completion: @escaping((Error?) -> Void)) {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            completion(error)
          } else {
            completion(nil)
          }
        }
    }
}

extension AuthService {
    func updateUserPassword(to password: String, completion: @escaping ((Error?) -> Void)) {
        Auth.auth().currentUser?.updatePassword(to: password, completion: { error in
            if let error = error {
                completion(error)
            }
            completion(nil)
        })
    }
    func requestPasswordReset(completion: @escaping((Error?) -> Void)) {
        if let email = Auth.auth().currentUser?.email {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                completion(error)
            }
            let error = NSError(domain: "de.craftcode.Wardrobe", code: 500, userInfo: ["NSLocalizedDescriptionKey": "No email found for this user."])
            completion(error)
        }
    }
}
