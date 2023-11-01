//
//  View+Layer.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 31.10.23.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
