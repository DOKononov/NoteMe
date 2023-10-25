//
//  UIView+addShadow.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.10.23.
//

import UIKit

extension UIView {
    
    func addShadow(){
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }

}
