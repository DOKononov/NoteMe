//
//  UIButton+Actions.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.11.23.
//

import UIKit

extension UIButton {
    
    @discardableResult
    func withAction(_ target: Any?,
                    _ selector: Selector,
                    for event: UIControl.Event = .touchUpInside) -> UIButton {
        self.addTarget(target, action: selector, for: event)
        return self
    }
}
