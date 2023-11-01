//
//  LineTextField.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 31.10.23.
//

import UIKit
import SnapKit

 class LineTextField: UIView {
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .appBoldFont.withSize(13)
        label.textColor = .appText
        label.textAlignment = .left
        return label
    }()
    
    internal lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.font = .appFont.withSize(15)
        textfield.textColor = .appText
        textfield.textAlignment = .left
        return textfield
    }()
    
    private lazy var separator: UIView = {
       let view = UIView()
        view.backgroundColor = .appText
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
        set { errorLabel.text = newValue }
    }
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var delegate: UITextFieldDelegate? {
        get { textField.delegate }
        set { textField.delegate = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
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
