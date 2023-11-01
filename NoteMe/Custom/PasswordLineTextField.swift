//
//  PasswordLineTextField.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 1.11.23.
//

import UIKit


final class PasswordLineTextField: LineTextField {
    
    override init() {
        super.init()
        configPasswordView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
   private  func configPasswordView() {
        textField.isSecureTextEntry = true
        let button = UIButton()
        setPasswordToggleImage(button)
        button.addTarget(self,
                         action: #selector(togglePasswordView),
                         for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    private func setPasswordToggleImage(_ button: UIButton) {
        textField.isSecureTextEntry ?
        button.setImage(.init(systemName: "eye.slash")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.appBlack), for: .normal) :
        button.setImage(.init(systemName: "eye")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.appRed), for: .normal)
    }
    
    @objc private func togglePasswordView(_ sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        setPasswordToggleImage(sender)
    }
}
