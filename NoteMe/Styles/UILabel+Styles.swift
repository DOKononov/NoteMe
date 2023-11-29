//
//  UILabel+Styles.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 1.11.23.
//

import UIKit

extension UILabel {
    
    static func titleLabel(_ title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .appBoldFont.withSize(25)
        label.textColor = .appText
        return label
    }
    
    static func popupLabel(_ title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .appFont.withSize(16)
        label.textColor = .appText
        return label
    }
}
