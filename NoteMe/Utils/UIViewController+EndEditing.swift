//
//  UIViewController+EndEditing.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 2.11.23.
//

import UIKit

extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
