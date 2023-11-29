//
//  ObnoardFirstStepVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit
import SnapKit

@objc protocol OnboardFirstStepViewModelProtocol {
    @objc func nextDidTap()
}

final class OnboardFirstStepVC: UIViewController {
    
    private var viewModel: OnboardFirstStepViewModelProtocol
    
    private lazy var contentView: UIView = .contentView()
    private lazy var logoContainer: UIView = UIView()
    private lazy var logoImageView: UIImageView = .init(image: .General.logo)
    private lazy var titleLabel: UILabel = .titleLabel(.Onboarding.welcome)
    private lazy var infoView: UIView = .infoView()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(13)
        label.text = .Onboarding.noteme_is_an_application_which_notify_you_about_everything
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var nextButton: UIButton =
        .yellowRoundedButton(.Onboarding.next)
        .withAction(viewModel, #selector(OnboardFirstStepViewModelProtocol.nextDidTap))
    
    
    init(viewModel: OnboardFirstStepViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
}

//MARK: -UI
private extension OnboardFirstStepVC {
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(infoLabel)
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(nextButton.snp.centerY)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(96)
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(infoView.snp.top).inset(-8)
        }
        
        infoView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
