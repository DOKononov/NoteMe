//
//  LineTextField.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 31.10.23.
//

import UIKit
import SnapKit

protocol LineTextFieldDelegate: AnyObject {
    func lineTextFieldDidChangeSelection(_ lineTextField: LineTextField)
}

final class LineTextField: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont.withSize(13)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.font = .appFont.withSize(15)
        textfield.textColor = .label
        textfield.textAlignment = .left
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont.withSize(12)
        label.textColor = .appRed
        label.textAlignment = .left
        return label
    }()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var errorText: String? {
        get { errorLabel.text }
        set {
            errorAnimation()
            errorLabel.text = newValue
        }
    }
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    weak var delegate: LineTextFieldDelegate?
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var inputView: UIView? {
        get { textField.inputView }
        set { textField.inputView = newValue }
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(separator)
        addSubview(errorLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4)
            make.height.equalTo(17)
            make.horizontalEdges.equalToSuperview()
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).inset(-4)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(separator.snp.bottom).inset(-4)
        }
        
    }
    
}

//MARK: -Styles
extension LineTextField {
    
    static func passwordView() -> LineTextField {
        let view = LineTextField()
        view.configPasswordView()
        return view
    }
}


//MARK: - private methods for passwordView

extension LineTextField {
    private func configPasswordView() {
        textField.isSecureTextEntry = true
        let button = UIButton()
        setPasswordToggleImage(button)
        button.addTarget(self,
                         action: #selector(togglePasswordView),
                         for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    @objc private func togglePasswordView(_ sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        setPasswordToggleImage(sender)
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
    
    private func errorAnimation() {
        UIView.transition(with: errorLabel,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            self?.errorLabel.textColor = .clear
        }) { [weak self] _ in
            self?.errorLabel.textColor = .appRed
        }
    }
}

//MARK: -UITextFieldDelegate
extension LineTextField: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.lineTextFieldDidChangeSelection(self)
    }
}
