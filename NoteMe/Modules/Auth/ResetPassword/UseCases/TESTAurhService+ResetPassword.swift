//
//  TESTAurhService+ResetPassword.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import Foundation

extension TESTAurhService: ResetPasswordAuthUseCase {
    func resetPassword(for email: String, completion: @escaping ((Bool) -> Void)) {
        completion(true)
    }
}
