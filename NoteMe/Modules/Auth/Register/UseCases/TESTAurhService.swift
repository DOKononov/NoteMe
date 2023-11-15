//
//  TESTAurhService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import Foundation

extension TESTAurhService: RegisterAuthServiceUseCase {
    func register(email: String, password: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    } 
}
