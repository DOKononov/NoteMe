//
//  RegisterAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 14.11.23.
//

import UIKit

final class RegisterAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let presenter = RegisterPresenter(keyboardHelper: KeyboardHelper())
        let view = RegisterVC(presenter: presenter)
        presenter.delegate = view
        return view
    }
}
