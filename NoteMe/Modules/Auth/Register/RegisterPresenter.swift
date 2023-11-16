//
//  RegisterPresenter.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 14.11.23.
//

import UIKit

protocol RegisterPresenterDelegate: AnyObject {
    func setEmailError(error: String?)
    func setPasswordError(error: String?)
    func setRepeatPasswordError(error: String?)
    
    func keyboardFrameChanged(_ frame: CGRect)
}

protocol RegisterAuthServiceUseCase {
    func register(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol RegisterInputValidatorUseCase {
    func validate(email: String?) -> Bool
    func validate(password: String?) -> Bool
}

protocol RegisterKeyboardHelperUseCase {
    func onWillShow(_ handler: @escaping KeyboardHelper.KeyboardFrameHandler) -> KeyboardHelper
    func onWillHide(_ handler: @escaping KeyboardHelper.KeyboardFrameHandler) -> KeyboardHelper
}

final class RegisterPresenter {
    
    weak var delegate: RegisterPresenterDelegate?
    private let keyboardHelper: RegisterKeyboardHelperUseCase
    private let inputValidator: RegisterInputValidatorUseCase
    private let authService: RegisterAuthServiceUseCase
    
    init(keyboardHelper: RegisterKeyboardHelperUseCase,
         inputValidator: RegisterInputValidatorUseCase,
         authService: RegisterAuthServiceUseCase) {
        self.keyboardHelper = keyboardHelper
        self.inputValidator = inputValidator
        self.authService = authService
        bind()
    }

}

//MARK: -RegisterPresenterProtocol
extension RegisterPresenter: RegisterPresenterProtocol {
    func registerDidTap(email: String?, password: String?, repeatPassword: String?) {
        guard
            checkValidation(email: email,
                            password: password,
                            repeatPassword: repeatPassword),
            let email, let password
        else { return }
        authService.register(email: email, password: password) { result in
            print(result)
        }
    }
    
    func haveAccountDidTap() { }
    
}

//MARK: -private methods
private extension RegisterPresenter {
    func checkValidation(email: String?,
                         password: String?,
                         repeatPassword: String?) -> Bool {
        let isValidEmail = inputValidator.validate(email: email)
        let isValidPassword = inputValidator.validate(password: password)
        let isPasswordMatches = (password == repeatPassword) && (password != "")
        
        
        delegate?.setEmailError(error: isValidEmail ? nil : .Auth.wrongEmail)
        delegate?.setPasswordError(error: isValidPassword ? nil : .Auth.nonValidPassword)
        delegate?.setRepeatPasswordError(error: isPasswordMatches ? nil : .Auth.passwordDoesNotMatch)
        
        return isValidEmail && isValidPassword && isPasswordMatches
    }
    
    func bind() {
        keyboardHelper
            .onWillShow { [weak self] in self?.delegate?.keyboardFrameChanged($0)}
            .onWillHide { [weak self] in self?.delegate?.keyboardFrameChanged($0)}
    }
}

