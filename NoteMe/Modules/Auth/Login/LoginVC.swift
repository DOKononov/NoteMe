//
//  LoginVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 24.10.23.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = .contentView()
    private lazy var logoImageView: UIImageView = .init(image: .General.logo)
    private lazy var titleLabel: UILabel = .titleLabel(.LoginVC.welcomeBack)
    private lazy var infoView: UIView = .infoView()
    
    private lazy var emailTextView: LineTextField = {
        let view = LineTextField()
        view.title = .LoginVC.email
        view.placeholder = .LoginVC.enterEmail
        return view
    }()
    
    private lazy var passwordTextView: LineTextField = {
        let view: LineTextField = .passwordView()
        view.title = .LoginVC.password
        view.placeholder = .LoginVC.enterPassword
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton = .underlineGrayButton(.LoginVC.forgotPassword)
    private lazy var loginButton: UIButton = .yellowRoundedButton(.LoginVC.login)
    private lazy var newAccountButton: UIButton = .underlineYellowButton(.LoginVC.newAccount)
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(emailTextView)
        infoView.addSubview(passwordTextView)
        infoView.addSubview(forgotPasswordButton)
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
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(infoView.snp.top).inset(-8)
        }
        
        infoView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        emailTextView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16)
        }
        
        passwordTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(emailTextView.snp.bottom).inset(-16)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextView.snp.bottom).inset(-20)
            make.height.equalTo(17)
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
