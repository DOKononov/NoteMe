//
//  AuthService+UseCase.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import Foundation

extension TESTAurhService: LoginAuthServiceUseCase {
   func login(email: String,
              password: String,
              completion: @escaping (Bool) -> Void) {
       completion(true)
   }
}
