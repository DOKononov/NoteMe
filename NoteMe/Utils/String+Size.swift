//
//  String+Size.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.03.24.
//

import UIKit

extension String {
    func minimumWidthToDisplay(font: UIFont, height: CGFloat) -> CGFloat {
        let label = UILabel()
        label.text = self
        label.font = font
        return label.sizeThatFits( .init( width: .infinity, height: height)).width
    }
}
