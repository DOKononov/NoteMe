//
//  ResetPasswordAssambler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import UIKit

final class ResetPasswordAssambler {
    private init(){}
    
    static func make(_ coordinator: ResetPasswordCoordinatorProtocol) -> UIViewController {
        let auth = AuthService()
        let inputValidator = InputValidator()
        let keyboardHelper = KeyboardHelper()
        let animatorService = AnimatorService()
        
        let viewModel = ResetPasswordVM(authService: auth,
                                        inputValidator: inputValidator,
                                        keyboardHelper: keyboardHelper,
                                        coordinator: coordinator)
        let view = ResetPasswordVC(viewModel: viewModel,
                                   animatorService: animatorService)
        return view
    }
}
