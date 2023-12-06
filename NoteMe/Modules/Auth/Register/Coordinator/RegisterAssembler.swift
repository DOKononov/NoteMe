//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    private init() {}
    
    static func make(coordinator: RegisterCoordinatorProtocol) -> UIViewController {
        let keyboardHelper = KeyboardHelper()
        let animatorService = AnimatorService()
        let inputValidator = InputValidator()
        let authService = AuthService()
        
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
