//
//  LoginVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func finish()
    func openRegisterModule()
    func openResetPasswordModule()
}

protocol LoginAuthServiceUseCase {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol LoginInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol LoginKeyboardHelperUseCase {
    typealias KeyboardFrameHandler = (CGRect) -> Void
    
    @discardableResult
    func onWillShow(_ handler: @escaping KeyboardFrameHandler) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping KeyboardFrameHandler) -> Self
}

final class LoginVM {
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    var keyboardFrameChanged: ((_ frame: CGRect) -> Void)?
    
    private weak var coordinator: LoginCoordinatorProtocol?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    private let keyboardHelper: LoginKeyboardHelperUseCase
    
    init(authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase,
         keyboardHelper: LoginKeyboardHelperUseCase,
         coordinator: LoginCoordinatorProtocol) {
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        bind()
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
                          password: password) { [weak coordinator] isSuccess in
            print(isSuccess)
            coordinator?.finish()
        }
    }
    
    func newAccountDidTapped() {
        coordinator?.openRegisterModule()
    }
    
    func forgotPasswordDidTapped(email: String?) {
        coordinator?.openResetPasswordModule()
    }
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
    
    func bind() {
        keyboardHelper
            .onWillHide { [weak self] in self?.keyboardFrameChanged?($0)}
            .onWillShow { [weak self] in self?.keyboardFrameChanged?($0)}
    }
}
