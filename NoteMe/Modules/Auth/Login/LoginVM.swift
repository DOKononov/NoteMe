//
//  LoginVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit
import FirebaseAuth

protocol LoginCoordinatorProtocol: AnyObject {
    func finish()
    func openRegisterModule()
    func openResetPasswordModule()
    func showAlert(_ alert: UIAlertController)
}

protocol LoginAuthServiceUseCase {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol LoginInputValidatorUseCase {
    func validate(email: String?) -> Bool
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
            if isSuccess {
                //TODO: FIXME: unkoment
//                ParametersHelper.set(.authenticated, value: true)
//                coordinator?.finish()
            } else {
                let alertVC = AlertBuilder.build(title: .AlertBuilder.error,
                                                 message: .AlertBuilder.invalid_email_or_password,
                                                 okTitile: .AlertBuilder.ok)
                coordinator?.showAlert(alertVC)
            }
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
        catchEmailError?(isEmailValid ? nil : .Auth.wrongEmail)
        
        return isEmailValid
    }
    
    func bind() {
        keyboardHelper
            .onWillHide { [weak self] in self?.keyboardFrameChanged?($0)}
            .onWillShow { [weak self] in self?.keyboardFrameChanged?($0)}
    }
}
