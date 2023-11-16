//
//  ResetPasswordVM.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import Foundation


protocol ResetPasswordAuthUseCase {
    func resetPassword(for email: String, completion: @escaping ((Bool)-> Void))
}

protocol ResetPasswordInputValidatorUseCase {
    func validate(email: String?) -> Bool
}

final class ResetPasswordVM {
    private let authService: ResetPasswordAuthUseCase
    private let inputValidator: ResetPasswordInputValidatorUseCase
    private let keyboardHelper: KeyboardHelper
    var catchEmailError: ((String?) -> Void)?
    var keyboardFrameChanged: ((_ frame: CGRect) -> Void)?
    
    init(authService: ResetPasswordAuthUseCase,
         inputValidator: ResetPasswordInputValidatorUseCase,
         keyboardHelper: KeyboardHelper) {
        self.authService = authService
        self.inputValidator = inputValidator
        self.keyboardHelper = keyboardHelper
        bind()
    }
}

//MARK: -ResetPasswordViewModelProtocol
extension ResetPasswordVM: ResetPasswordViewModelProtocol {
    
    func resetDidTap(email: String?) {
        let isValidEmail = inputValidator.validate(email: email)
        catchEmailError?(isValidEmail ? nil : .Auth.wrongEmail)
        
        guard let email, isValidEmail else { return }
        authService.resetPassword(for: email) { result in
            print(result)
        }
    }
    
    func cancelDidTap() {}
    
}

//MARK: -private methods
private extension ResetPasswordVM {
    func bind() {
        keyboardHelper.onWillShow { [weak self] in self?.keyboardFrameChanged?($0)}
        keyboardHelper.onWillHide { [weak self] in self?.keyboardFrameChanged?($0)}
    }
}
