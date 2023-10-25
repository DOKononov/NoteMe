//
//  AppInputView.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.10.23.
//

import UIKit

final class AppTextFieldView: UIView {
    
    enum ViewType {
        case textView
        case passwordView
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .appTextFieldLabelFont
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.font = .appErrorLabelFont
        label.textColor = .appRed
        return label
    }()
    
    
    init(title: String, placeholder: String, type: ViewType) {
        super.init(frame: .zero)
        setupUI()
        setupLayouts()
        setupView(title: title, placeholder: placeholder, type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(title: String,
                           placeholder: String,
                           type: ViewType) {
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        switch type {
        case .textView:
            break
        case .passwordView:
            configPasswordView()
        }
    }
    
    func showError(_ text: String) {
        errorLabel.isHidden = false
        errorLabel.text = text
    }
}

//MARK: -SetupUI
private extension AppTextFieldView {
    func setupUI() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(separator)
        addSubview(errorLabel)
    }
    
    func setupLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(17)
        }
        
        separator.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(textField.snp.bottom).offset(4)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.top.equalTo(separator.snp.bottom).offset(4)
        }
    }
}


//MARK: -passwordView config
private extension AppTextFieldView {
    func configPasswordView() {
        textField.isSecureTextEntry = true
        let button = UIButton()
        setPasswordToggleImage(button)
        button.addTarget(self,
                         action: #selector(togglePasswordView),
                         for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    func setPasswordToggleImage(_ button: UIButton) {
        textField.isSecureTextEntry ?
        button.setImage(.init(systemName: "eye.slash")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.appBlack), for: .normal) :
        button.setImage(.init(systemName: "eye")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.appRed), for: .normal)
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        setPasswordToggleImage(sender)
    }
}
