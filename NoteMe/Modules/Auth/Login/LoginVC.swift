//
//  LoginVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 24.10.23.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: .General.logo)
        return view
    }()
    
    private lazy var welcomeLabel: UILabel = {
       let label = UILabel()
        label.text = .LoginVC.welcomeBack
        label.font = .appTitleFont
        label.textColor = .black
        return label
    }()
    
    private lazy var middleContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.addShadow()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var emailTextView: AppTextFieldView = {
        let view = AppTextFieldView(title: .LoginVC.email,
                                    placeholder: .LoginVC.enterEmail,
                                    type: .textView)
        return view
    }()
    
    private lazy var passwordTextView: AppTextFieldView = {
        let view = AppTextFieldView(title: .LoginVC.password,
                                    placeholder: .LoginVC.enterPassword,
                                    type: .passwordView)
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.appLabel, for: .normal)
        let title = String.LoginVC.forgotPassword
        button.setAttributedTitle(title.makeUnderline(.appLabel),
                                  for: .normal)
        button.titleLabel?.font = .appBoldFont15
        button.addTarget(self,
                         action: #selector(forgotButtonDidTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: AppButton = {
        let button = AppButton(style: .primary, title: .LoginVC.login)
        button.addTarget(self, action: #selector(loginButtonDidTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var newAccountButton: AppButton = {
        let button = AppButton(style: .underline, title: .LoginVC.newAccount)
        button.addTarget(self, action: #selector(newAccountButtonDidTapped),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
  
}

//MARK: -Private methods

private extension LoginVC {
    @objc func forgotButtonDidTapped() {
        //TODO: setup logic
    }
    
    @objc func loginButtonDidTapped() {
        //TODO: setup logic
    }
    
    @objc func newAccountButtonDidTapped() {
        //TODO: setup logic
    }
}

//MARK: -SetupUI
private extension LoginVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(middleContentView)
        middleContentView.addSubview(emailTextView)
        middleContentView.addSubview(passwordTextView)
        middleContentView.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(newAccountButton)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(loginButton.snp.centerY)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(72)
            make.size.equalTo(96)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(middleContentView.snp.top).inset(-8)
        }
        
        middleContentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        emailTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        passwordTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(emailTextView.snp.bottom).inset(-16)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextView.snp.bottom).inset(-20)
            make.leading.bottom.equalToSuperview().inset(16)
        }
        
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.bottom.equalTo(newAccountButton.snp.top).inset(-8)
        }
        
        newAccountButton.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
