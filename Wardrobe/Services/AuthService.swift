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
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.userIsSignedIn = true
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
                completion(.success(user))
            }
        }
    }
    func loginEPAccount(email: String, password: String, completion: @escaping((Result<User, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
    func logoutEPAccount(email: String, password: String, completion: @escaping((Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            do {
                try Auth.auth().signOut()
                completion(nil)
            } catch let signOutError as NSError {
                completion(signOutError)
            }
        }
    }
}
