//
//  SignupViewModel.swift
//  Wardrobe
//
//  Created by Roman Zuchowski on 07.04.24.
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var signUpDisalbed: Bool = true
    @Published var mailIsValid: Bool?
    @Published var passwordIsValid: Bool?
}

extension SignupViewModel {
    func validateSignupForm() {
        if let mailIsValid = mailIsValid, let passwordIsValid = passwordIsValid {
            if mailIsValid == true && passwordIsValid == true {
                self.signUpDisalbed = false
            }
        }
    }
    
    func isEqualPassword(_ password: String, check passwordCheck: String) {
        self.passwordIsValid = password == passwordCheck
    }
    
    func isValidEmail(_ email: String) {
        // Regular expression pattern for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        // Create NSPredicate with format matching email regex
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        // Evaluate predicate with email string
        DispatchQueue.main.async {
            self.mailIsValid = emailPredicate.evaluate(with: email)
        }
    }
}
