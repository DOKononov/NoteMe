//
//  LoginAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit

final class LoginAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let vm = LoginVM(authService: TESTAurhService(),
                         inputValidator: InputValidator())
        return LoginVC(viewModel: vm)
    }
}


 class TESTAurhService: LoginAuthServiceUseCase {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
