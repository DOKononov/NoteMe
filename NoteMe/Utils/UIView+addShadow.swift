//
//  UIView+addShadow.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.10.23.
//

import UIKit

extension UIView {
    
    func addShadow(){
        self.layer.shadowColor = UIColor.appShadow.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }

}
