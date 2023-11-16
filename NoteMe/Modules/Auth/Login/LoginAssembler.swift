//
//  LoginAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit

final class LoginAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let authService = TESTAurhService()
        let keybordHelper = KeyboardHelper()
        let inputValidator = InputValidator()
        let animatorService = AnimatorService()
        
        let viewModel = LoginVM(authService: authService,
                         inputValidator: inputValidator,
                         keyboardHelper: keybordHelper)
        let view =  LoginVC(viewModel: viewModel,
                            animatorService: animatorService)
        
        return view
    }
}


