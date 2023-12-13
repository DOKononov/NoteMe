//
//  AlertService+Login.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import Foundation

extension AlertService: LoginAlertServiceUseCase {
    func showAlert(title: String, message: String, okTitile: String) {
        showAlert(title: title, message: message, okTitile: okTitile, okHandler: nil)
    }
}
