//
//  AlertService+Profile.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 23.12.23.
//

import UIKit

extension AlertService: ProfileAlertServiceUseCase {
    func showAlert(title: String?,
                   message: String?,
                   cancelTitile: String?,
                   cancelStyle: UIAlertAction.Style?,
                   okTitile: String?,
                   okHandler: (() -> Void)?,
                   okStyle: UIAlertAction.Style?) {
        self.showAlert(title: title,
                       message: message,
                       cancelTitile: cancelTitile,
                       cancelHandler: nil,
                       cancelStyle: cancelStyle,
                       okTitile: okTitile,
                       okHandler: okHandler,
                       okStyle: okStyle)
    }
}
