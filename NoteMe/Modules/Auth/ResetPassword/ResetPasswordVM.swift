//
//  ResetPasswordVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import UIKit

protocol ResetPasswordCoordinatorProtocol: AnyObject {
    func finish()
    func showAlert(_ alert: UIAlertController)
}

protocol ResetPasswordAuthUseCase {
    func resetPassword(for email: String, completion: @escaping ((Bool)-> Void))
}

protocol ResetPasswordAlertServiceUseCase {
    func showAlert(title: String,
                   message: String,
                   okTitile: String,
                   okHandler: (() -> Void)?)
}

protocol ResetPasswordInputValidatorUseCase {
    func validate(email: String?) -> Bool
}

protocol ResetPasswordKeyboardHelperUseCase {
    typealias KeyboardFrameHandler = (CGRect) -> Void
    
    @discardableResult
    func onWillShow(_ handler: @escaping KeyboardFrameHandler) -> Self
    @discardableResult
    func onWillHide(_ handler: @escaping KeyboardFrameHandler) -> Self
}

final class ResetPasswordVM {
    private let authService: ResetPasswordAuthUseCase
    private let inputValidator: ResetPasswordInputValidatorUseCase
    private let keyboardHelper: ResetPasswordKeyboardHelperUseCase
    private let alertService: ResetPasswordAlertServiceUseCase
    private weak var coordinator: ResetPasswordCoordinatorProtocol?
    var catchEmailError: ((String?) -> Void)?
    var keyboardFrameChanged: ((_ frame: CGRect) -> Void)?
    
    init(authService: ResetPasswordAuthUseCase,
         inputValidator: ResetPasswordInputValidatorUseCase,
         keyboardHelper: ResetPasswordKeyboardHelperUseCase,
         coordinator: ResetPasswordCoordinatorProtocol,
         alertService: ResetPasswordAlertServiceUseCase) {
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        self.alertService = alertService
        bind()
    }
}

//MARK: -ResetPasswordViewModelProtocol
extension ResetPasswordVM: ResetPasswordViewModelProtocol {
    
    func resetDidTap(email: String?) {
        let isValidEmail = inputValidator.validate(email: email)
        catchEmailError?(isValidEmail ? nil : .Auth.wrongEmail)
        
        guard let email, isValidEmail else { return }
        authService.resetPassword(for: email) { [weak self] isSuccess in
            if isSuccess {
                self?.alertService.showAlert(
                    title: .AlertBuilder.success,
                    message: .AlertBuilder.we_have_sent_a_link_to_reset_your_password_to + " \(email)",
                    okTitile: .AlertBuilder.ok) { [weak self] in
                        self?.coordinator?.finish()
                    }
            } else {
                self?.alertService.showAlert(
                    title: .AlertBuilder.error,
                    message: .AlertBuilder.invalid_email_address + " \(email)",
                    okTitile: .AlertBuilder.ok,
                    okHandler: nil)
            }
        }
    }
    
    func cancelDidTap() {
        coordinator?.finish()
    }
}

//MARK: -private methods
private extension ResetPasswordVM {
    func bind() {
        keyboardHelper
            .onWillShow { [weak self] in self?.keyboardFrameChanged?($0)}
            .onWillHide { [weak self] in self?.keyboardFrameChanged?($0)}
    }
}
