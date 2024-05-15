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
}

protocol LoginAuthServiceUseCase {
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
}

protocol LoginAlertServiceUseCase {
    func showAlert(title: String, message: String, okTitile: String)
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

protocol LoginNotificationDataWorkerUsecase {
    func restore(completion: ((Bool) -> Void)?)
}

final class LoginVM {
    var catchEmailError: ((String?) -> Void)?
    var catchPasswordError: ((String?) -> Void)?
    var keyboardFrameChanged: ((_ frame: CGRect) -> Void)?
    
    private weak var coordinator: LoginCoordinatorProtocol?
    
    private let authService: LoginAuthServiceUseCase
    private let inputValidator: LoginInputValidatorUseCase
    private let keyboardHelper: LoginKeyboardHelperUseCase
    private let alertService: LoginAlertServiceUseCase
    private let worker: LoginNotificationDataWorkerUsecase
    
    init(authService: LoginAuthServiceUseCase,
         inputValidator: LoginInputValidatorUseCase,
         keyboardHelper: LoginKeyboardHelperUseCase,
         coordinator: LoginCoordinatorProtocol,
         alertService: LoginAlertServiceUseCase,
         worker: LoginNotificationDataWorkerUsecase
    ) {
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.alertService = alertService
        self.worker = worker
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
                          password: password) { [weak self] isSuccess in
            if isSuccess {
                ParametersHelper.set(.authenticated, value: true)
                //start load backup
                self?.worker.restore { isSuccess in
                    DispatchQueue.main.async {
                        self?.coordinator?.finish()
                    }
                }
            } else {
                self?.alertService.showAlert(title: .AlertBuilder.error,
                                       message: .AlertBuilder.invalid_email_or_password,
                                       okTitile: .AlertBuilder.ok)
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
        let isPasswordValid = passwordValidation(password: password)
        catchEmailError?(isEmailValid ? nil : .Auth.wrongEmail)
        catchPasswordError?(isPasswordValid ? nil : .Auth.nonValidPassword)
        
        return isEmailValid && isPasswordValid
    }
    
    func passwordValidation(password: String?) -> Bool {
        guard let password else { return false }
        return password.isEmpty ? false : true
    }
    
    func bind() {
        keyboardHelper
            .onWillHide { [weak self] in self?.keyboardFrameChanged?($0)}
            .onWillShow { [weak self] in self?.keyboardFrameChanged?($0)}
    }
}
