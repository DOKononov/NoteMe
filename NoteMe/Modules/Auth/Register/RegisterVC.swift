//
//  RegisterVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 2.11.23.
//

import UIKit
import SnapKit

@objc protocol RegisterPresenterProtocol: AnyObject {
    func registerDidTap(email: String?,
                        password: String?,
                        repeatPassword: String?)
    @objc func haveAccountDidTap()
}

final class RegisterVC: UIViewController {
    
    private let animatorService: AnimatorService
    private lazy var contentView: UIView = .contentView()
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView = .init(image: .General.logo)
    private lazy var titleLabel: UILabel = .titleLabel(.Auth.niceToMeetYou)
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
    
    private lazy var repeatPasswordTextView: LineTextField = {
        let view: LineTextField = .passwordView()
        view.title = .Auth.repeatPassword
        view.placeholder = .Auth.enterPassword
        return view
    }()
    
    private lazy var registerButton: UIButton =
        .yellowRoundedButton(.Auth.register)
        .withAction(self, #selector(registerDidTap))
    
    private lazy var iHaveAnAccountButton: UIButton =
        .underlineYellowButton(.Auth.iHaveAnAccount)
        .withAction(presenter,
                    #selector(RegisterPresenterProtocol.haveAccountDidTap))
    
    private var presenter: RegisterPresenterProtocol
    
    init(presenter: RegisterPresenterProtocol,
         animatorService: AnimatorService) {
        self.presenter = presenter
        self.animatorService = animatorService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayouts()
    }
}

//MARK: -setupUI
private extension RegisterVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(emailTextView)
        infoView.addSubview(passwordTextView)
        infoView.addSubview(repeatPasswordTextView)
        view.addSubview(registerButton)
        view.addSubview(iHaveAnAccountButton)
    }
    
    func setupLayouts() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(registerButton.snp.centerY)
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
            make.top.horizontalEdges.equalToSuperview().inset(16)
        }
        
        passwordTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(emailTextView.snp.bottom).inset(-16)
        }
        
        repeatPasswordTextView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(16)
            make.top.equalTo(passwordTextView.snp.bottom).inset(-16)
        }
        
        registerButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.bottom.equalTo(iHaveAnAccountButton.snp.top).inset(-8)
        }
        
        iHaveAnAccountButton.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


//MARK: -private methods
private extension RegisterVC {
    @objc private func registerDidTap() {
        presenter.registerDidTap(email: emailTextView.text,
                                 password: passwordTextView.text,
                                 repeatPassword: repeatPasswordTextView.text)
    }
}


extension RegisterVC: RegisterPresenterDelegate {
    func setEmailError(error: String?) {
        emailTextView.errorText = error
    }
    
    func setPasswordError(error: String?) {
        passwordTextView.errorText = error
    }
    
    func setRepeatPasswordError(error: String?) {
        repeatPasswordTextView.errorText = error
    }
    
    func keyboardFrameChanged(_ frame: CGRect) {
        animatorService.moveWithAnimation(for: self,
                                          infoView: infoView,
                                          toSatisfyKeyboard: frame)
    }

    
}
