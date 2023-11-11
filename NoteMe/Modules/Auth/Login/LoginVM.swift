//
//  LoginVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit

protocol LoginAuthServiceUseCase {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol LoginInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

final class LoginVM: LoginViewModelProtocol {
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    
    init(authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase) {
        self.authService = authService
        self.inputValidator = inputValidator
    }
    
    func loginDidTapped(email: String?, password: String?) {
        guard inputValidator.validate(email: email) else {
            catchEmailError?("Wrong email")
            return
        }
        catchEmailError?(nil)

        
        guard inputValidator.validate(password: password) else {
            catchPasswordError?("Non-valid password")
            return
        }
        catchPasswordError?(nil)
 
        guard let email, let password else { return }
        authService.login(email: email,
                          password: password) { isSuccess in
            print(isSuccess)
        }
    }
    
    func newAccountDidTapped() { }
    
    func forgotPasswordDidTapped(email: String?) { }
    
    
}
