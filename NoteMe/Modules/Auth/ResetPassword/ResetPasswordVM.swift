//
//  ResetPasswordVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import Foundation

protocol ResetPasswordCoordinatorProtocol: AnyObject {
    func finish()
}

protocol ResetPasswordAuthUseCase {
    func resetPassword(for email: String, completion: @escaping ((Bool)-> Void))
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
    private weak var coordinator: ResetPasswordCoordinatorProtocol?
    var catchEmailError: ((String?) -> Void)?
    var keyboardFrameChanged: ((_ frame: CGRect) -> Void)?
    
    init(authService: ResetPasswordAuthUseCase,
         inputValidator: ResetPasswordInputValidatorUseCase,
         keyboardHelper: ResetPasswordKeyboardHelperUseCase,
         coordinator: ResetPasswordCoordinatorProtocol) {
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
        self.coordinator = coordinator
        bind()
    }
}

//MARK: -ResetPasswordViewModelProtocol
extension ResetPasswordVM: ResetPasswordViewModelProtocol {
    
    func resetDidTap(email: String?) {
        let isValidEmail = inputValidator.validate(email: email)
        catchEmailError?(isValidEmail ? nil : .Auth.wrongEmail)
        
        guard let email, isValidEmail else { return }
        authService.resetPassword(for: email) { [weak coordinator] result in
            print(result)
            coordinator?.finish()
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
