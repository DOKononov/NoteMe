//
//  ResetPasswordVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 2.11.23.
//

import UIKit
import SnapKit

@objc protocol ResetPasswordViewModelProtocol {
    var catchEmailError: ((String?)-> Void)? { get set }
    func resetDidTap(email: String?)
    @objc func cancelDidTap()
    var keyboardFrameChanged: ((_ frame: CGRect) -> Void)? { get set }
}

final class ResetPasswordVC: UIViewController {
    
    private var viewModel: ResetPasswordViewModelProtocol
    private var animatorService: AnimatorService
    private lazy var contentView: UIView = .contentView()
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView = .init(image: .General.logo)
    private lazy var titleLabel: UILabel = .titleLabel(.Auth.resetPassword)
    private lazy var infoView: UIView = .infoView()
    
    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .appFont.withSize(13)
        label.textColor = .appText
        label.textAlignment = .natural
        label.text = .Auth.enterYourEmailAdressAndWeWillShareALinkToCreateANewPassword
        return label
    }()
    
    private lazy var emailTextView: LineTextField = {
        let view = LineTextField()
        view.placeholder = .Auth.enterEmail
        return view
    }()
    
    private lazy var resetButton: UIButton =
        .yellowRoundedButton(.Auth.reset)
        .withAction(self, #selector(resetDidTap))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(viewModel,
                    #selector(ResetPasswordViewModelProtocol.cancelDidTap))
    
    init(viewModel: ResetPasswordViewModelProtocol,
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
        setupLayouts()
    }
}

//MARK: -private methods
private extension ResetPasswordVC {
    @objc private func resetDidTap() {
        viewModel.resetDidTap(email: emailTextView.text)
    }
    
    private func bind() {
        viewModel.catchEmailError = { [weak self] error in
            self?.emailTextView.errorText = error
        }
        viewModel.keyboardFrameChanged = { [weak self] frame in
            guard let self else { return }
            animatorService.moveWithAnimation(for: self,
                                              infoView: infoView,
                                              toSatisfyKeyboard: frame)
        }
    }
}

//MARK: - setupUI
private extension ResetPasswordVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(viewLabel)
        infoView.addSubview(emailTextView)
        view.addSubview(resetButton)
        view.addSubview(cancelButton)
    }
    
    func setupLayouts() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(resetButton.snp.centerY)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
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
        
        viewLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(16)
        }
        
        emailTextView.snp.makeConstraints { make in
            make.top.equalTo(viewLabel.snp.bottom).inset(-8)
            make.horizontalEdges.bottom.equalToSuperview().inset(16)
        }
        
        resetButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.bottom.equalTo(cancelButton.snp.top).inset(-8)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
