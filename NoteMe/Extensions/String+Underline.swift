//
//  String+Underline.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.10.23.
//

import UIKit

extension String {
    func makeUnderline(_ color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: self.count))
        attributedString.addAttribute(.underlineColor,
                                      value: color,
                                      range: NSRange(location: 0, length: self.count))
        return attributedString
    }
}
