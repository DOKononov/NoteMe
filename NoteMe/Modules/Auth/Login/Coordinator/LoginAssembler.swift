//
//  LoginAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit

final class LoginAssembler {
    private init() {}
    
    
    static func make(container: Container,
                     coordinator: LoginCoordinatorProtocol) -> UIViewController {
        let authService: AuthService = container.resolve()
        let keybordHelper: KeyboardHelper = container.resolve()
        let inputValidator: InputValidator = container.resolve()
        let animatorService: AnimatorService = container.resolve()
        let alertService: AlertService = container.resolve()
        
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


