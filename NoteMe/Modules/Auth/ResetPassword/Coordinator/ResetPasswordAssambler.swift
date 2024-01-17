//
//  ResetPasswordAssambler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.11.23.
//

import UIKit

final class ResetPasswordAssambler {
    private init(){}
    
    static func make(_ coordinator: ResetPasswordCoordinatorProtocol,
                     container: Container) -> UIViewController {
        
        let authService: AuthService = container.resolve()
        let inputValidator: InputValidator = container.resolve()
        let keyboardHelper: KeyboardHelper = container.resolve()
        let animatorService: AnimatorService = container.resolve()
        let alertService: AlertService = container.resolve()
        
        let viewModel = ResetPasswordVM(authService: authService,
                                        inputValidator: inputValidator,
                                        keyboardHelper: keyboardHelper,
                                        coordinator: coordinator,
                                        alertService: alertService)
        let view = ResetPasswordVC(viewModel: viewModel,
                                   animatorService: animatorService)
        return view
    }
}
