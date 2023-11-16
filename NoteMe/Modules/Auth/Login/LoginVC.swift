//
//  LoginVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 24.10.23.
//

import UIKit
import SnapKit

@objc protocol LoginViewModelProtocol: AnyObject {
    var catchEmailError: ((String?)-> Void)? { get set }
    var catchPasswordError: ((String?)-> Void)? { get set }
    
    func loginDidTapped(email: String?, password: String?)
    @objc func newAccountDidTapped()
    func forgotPasswordDidTapped(email: String?)
    var keyboardFrameChanged: ((_ frame: CGRect) -> Void)? { get set }
}

final class LoginVC: UIViewController {
    
    private var viewModel: LoginViewModelProtocol
    private let animatorService: AnimatorService
    
    private lazy var contentView: UIView = .contentView()
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView = .init(image: .General.logo)
    private lazy var titleLabel: UILabel = .titleLabel(.Auth.welcomeBack)
    private lazy var infoView: UIView = .infoView()
    
    private lazy var emailTextView: LineTextField = {
        let view = LineTextField()
        view.title = .Auth.email
        view.placeholder = .Auth.enterEmail
        return view
    }()
    
    private lazy var passwordTextView: LineTextField = {
        let view: LineTextField = .passwordView()
        view.title = .Auth.password
        view.placeholder = .Auth.enterPassword
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton =
        .underlineGrayButton(.Auth.forgotPassword)
        .withAction(self, #selector(forgotPasswordDidTap))
    
    private lazy var loginButton: UIButton =
        .yellowRoundedButton(.Auth.login)
        .withAction(self, #selector(loginDidTap))
    
    private lazy var newAccountButton: UIButton =
        .underlineYellowButton(.Auth.newAccount)
        .withAction(viewModel,
                    #selector(LoginViewModelProtocol.newAccountDidTapped))
    
    init(viewModel: LoginViewModelProtocol,
         animatorService: AnimatorService) {
        self.viewModel = viewModel
        self.animatorService = animatorService
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
    
    @objc func loginDidTap() {
        viewModel.loginDidTapped(email: emailTextView.text,
                                 password: passwordTextView.text)
    }
    
    @objc func forgotPasswordDidTap() {
        viewModel.forgotPasswordDidTapped(email: emailTextView.text)
    }
    
    private func bind() {
        viewModel.catchEmailError = {  [weak self] errorText in
            self?.emailTextView.errorText = errorText
        }
        
        viewModel.catchPasswordError = { [weak self] in
            self?.passwordTextView.errorText = $0
        }
        
        viewModel.keyboardFrameChanged = { [weak self] frame in
            guard let self else { return }
            animatorService.moveWithAnimation(for: self,
                                              infoView: infoView,
                                              toSatisfyKeyboard: frame)
        }
    }
}

//MARK: -SetupUI
private extension LoginVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)
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
        
        logoContainer.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
