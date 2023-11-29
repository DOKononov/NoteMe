//
//  TextFormatter.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 29.11.23.
//

import UIKit


struct TextFormatter {
    private let regularFont = UIFont.appFont.withSize(13)
    private let boldFont = UIFont.appBoldFont.withSize(13)
    
    func setAttributes(to string: String) -> NSAttributedString {
        let components = string.components(separatedBy: "**")
        let sequence = components.enumerated()
        let attributedString = NSMutableAttributedString()

        return sequence.reduce(into: attributedString) { string, pair in
            let isBold = !pair.offset.isMultiple(of: 2)
            let font = isBold ? boldFont : regularFont

            string.append(NSAttributedString( string: pair.element,
                                              attributes: [.font: font]))
        }
    }
}
