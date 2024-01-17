//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    private init() {}
    
    static func make(coordinator: RegisterCoordinatorProtocol,
                     container: Container) -> UIViewController {
        let keyboardHelper: KeyboardHelper = container.resolve()
        let animatorService: AnimatorService = container.resolve()
        let inputValidator: InputValidator = container.resolve()
        let authService: AuthService = container.resolve()
        
        let presenter = RegisterPresenter(keyboardHelper: keyboardHelper,
                                          inputValidator: inputValidator,
                                          authService: authService,
                                          coordinator: coordinator)
        let view = RegisterVC(presenter: presenter,
                              animatorService: animatorService)
        presenter.delegate = view
        return view
    }
}
