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

final class LoginVM {
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    
    init(authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase) {
        self.authService = authService
        self.inputValidator = inputValidator
    }
    
}

//MARK: -LoginViewModelProtocol
extension LoginVM: LoginViewModelProtocol {
    
    func loginDidTapped(email: String?, password: String?) {
    
        guard
            checkValidation(email: email, password: password),
            let email, let password
        else { return }
        
        authService.login(email: email,
                          password: password) { isSuccess in
            print(isSuccess)
        }
    }
    
    func newAccountDidTapped() { }
    
    func forgotPasswordDidTapped(email: String?) { }
    
}

//MARK: - private methods
private extension LoginVM {
    func checkValidation(email: String?, password: String?) -> Bool {
        
        let isEmailValid = inputValidator.validate(email: email)
        let isPasswordValid = inputValidator.validate(password: password)
        
        catchEmailError?(isEmailValid ? nil : .Auth.wrongEmail)
        catchPasswordError?(isPasswordValid ? nil : .Auth.enterPassword)
    
       return isEmailValid && isPasswordValid
    }
}
