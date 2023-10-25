//
//  AppButton.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.10.23.
//

import UIKit

final class AppButton: UIButton {
    
    private var style: ButtonStyle = .primary {
        didSet {
            applyStyle()
        }
    }
    
    init(style: ButtonStyle, title: String) {
        super.init(frame: .zero)
        self.style = style
        titleLabel?.text = title
        setup()
        applyStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel?.font = .appBoldFont
        layer.cornerRadius = 5
    }
    
    private func applyStyle() {
        setTitleColor(style.textColor, for: .normal)
        backgroundColor = style.backgroundColor
        layer.borderWidth = style.hasBorder ? 1 : 0
        layer.borderColor = style.borderColor
        
        guard
            let title = titleLabel?.text
        else { return }
        style.underlineTitle ?
        setAttributedTitle(title.makeUnderline(.appYellow),for: .normal) :
        setTitle(title, for: .normal)
    }
    
    override var isHighlighted: Bool {
        didSet {
            titleLabel?.textColor = isHighlighted ? .appGray : style.textColor
        }
    }
    
}




//MARK: -ButtonStyle
extension AppButton {
    enum ButtonStyle {
        case primary
        case underline
        case cancel
        
        var backgroundColor: UIColor {
            switch self {
            case .primary:
                return .appYellow
            case .cancel, .underline:
                return .clear
            }
        }
        
        var underlineTitle: Bool {
            self == .underline
        }
        
        var borderColor: CGColor {
            switch self {
            case .cancel:
                return UIColor.appYellow.cgColor
            case .primary, .underline:
                return UIColor.clear.cgColor
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .primary:
                return .black
            case .cancel, .underline:
                return .appYellow
            }
        }
        
        var hasBorder: Bool {
            self == .cancel
        }
    }
}
