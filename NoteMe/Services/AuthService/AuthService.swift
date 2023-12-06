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
}
