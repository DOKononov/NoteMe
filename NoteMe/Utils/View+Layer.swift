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
    
    func addShadow(){
        self.layer.shadowColor = UIColor.appShadow.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }
}
