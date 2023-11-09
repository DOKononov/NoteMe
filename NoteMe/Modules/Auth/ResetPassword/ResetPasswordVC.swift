//
//  ResetPasswordVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 2.11.23.
//

import UIKit
import SnapKit

final class ResetPasswordVC: UIViewController {
    
    private lazy var contentView: UIView = .contentView()
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
    
    private lazy var resetButton: UIButton = .yellowRoundedButton(.Auth.reset)
    private lazy var cancelButton: UIButton = .appCancelButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayouts()
    }
}

//MARK: - setupUI
private extension ResetPasswordVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoImageView)
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
