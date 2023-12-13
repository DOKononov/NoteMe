//
//  AlertService+ResetPassword.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit

extension AlertService: ResetPasswordAlertServiceUseCase {
    func showAlert(title: String, message: String, okTitile: String, okHandler: (() -> Void)?) {
        showAlert(title: title, message: message, cancelHandler: nil, okTitile: okTitile, okHandler: okHandler)
    }
}
