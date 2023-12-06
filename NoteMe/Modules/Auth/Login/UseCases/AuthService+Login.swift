//
//  AuthService+UseCase.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import Foundation

extension AuthService: LoginAuthServiceUseCase {
   func login(email: String,
              password: String,
              completion: @escaping (Bool) -> Void) {
       self.signIn(email: email, password: password, completion: completion)
   }
}
