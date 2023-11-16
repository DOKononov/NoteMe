//
//  ResetPasswordAssambler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import UIKit

final class ResetPasswordAssambler {
    private init(){}
    
    static func make() -> UIViewController {
        let auth = TESTAurhService()
        let inputValidator = InputValidator()
        let keyboardHelper = KeyboardHelper()
        let animatorService = AnimatorService()
        
        let viewModel = ResetPasswordVM(authService: auth,
                                        inputValidator: inputValidator,
                                        keyboardHelper: keyboardHelper)
        let view = ResetPasswordVC(viewModel: viewModel,
                                   animatorService: animatorService)
        return view
    }
}
