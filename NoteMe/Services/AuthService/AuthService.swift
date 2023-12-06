//
//  AuthService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 5.12.23.
//

import Foundation
import FirebaseAuth

final class AuthService {
    
    private var firebase: Auth { Auth.auth() }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Bool) -> Void) {
        firebase.signIn(withEmail: email, password: password) { result, error in
            completion(error == nil)
        }
    }
    
    func register(email: String,
                  password: String,
                  completion: @escaping (Bool)-> Void) {
        firebase.createUser(withEmail: email, password: password) { result, error in
            completion(error == nil)
        }
    }
    
    func resetPassword(for email: String, completion: @escaping ((Bool) -> Void)) {
        firebase.sendPasswordReset(withEmail: email) { completion($0 == nil) }
    }
}
