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

final class RegisterPresenter {
    
    weak var delegate: RegisterPresenterDelegate?
    
    private let keyboardHelper: KeyboardHelper
    
    init(keyboardHelper: KeyboardHelper) {
        self.keyboardHelper = keyboardHelper
        bind()
    }
    
    private func bind() {
        keyboardHelper
            .onWillShow { [weak self] in self?.delegate?.keyboardFrameChanged($0)}
            .onWillHide { [weak self] in self?.delegate?.keyboardFrameChanged($0)}
    }
    
}

//MARK: -RegisterPresenterProtocol
extension RegisterPresenter: RegisterPresenterProtocol {
    func registerDidTap(email: String?, password: String?, repeatPassword: String?) { }
    
    func haveAccountDidTap() { }
    
}


///logo container
///regisre UI
///forgot password VC
///UseCase keyboard helper
///
