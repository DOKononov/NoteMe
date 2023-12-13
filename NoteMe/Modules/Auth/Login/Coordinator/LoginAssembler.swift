//
//  LoginAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit

final class LoginAssembler {
    private init() {}
    
    static func make(coordinator: LoginCoordinatorProtocol) -> UIViewController {
        let authService = AuthService()
        let keybordHelper = KeyboardHelper()
        let inputValidator = InputValidator()
        let animatorService = AnimatorService()
        let alertService = AlertService.current
        
        let viewModel = LoginVM(authService: authService,
                                inputValidator: inputValidator,
                                keyboardHelper: keybordHelper,
                                coordinator: coordinator,
                                alertService: alertService)
        let view =  LoginVC(viewModel: viewModel,
                            animatorService: animatorService)
        
        return view
    }
}


