//
//  UIView+Styles.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 1.11.23.
//

import UIKit

extension UIView {
    
    static func infoView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.addShadow()
        view.backgroundColor = .itemBackground
        return view
    }
    
    static func contentView() -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .appGray
        return view
    }
}
