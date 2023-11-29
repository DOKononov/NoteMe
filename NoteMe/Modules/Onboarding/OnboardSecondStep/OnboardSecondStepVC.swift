//
//  OnboardSecondStepVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 28.11.23.
//

import UIKit
import SnapKit

@objc protocol OnboardSecondStepViewModelProtocol {
    @objc func doneDidTap()
    func dismissedByUser()
    func setAttributes(to string: String) -> NSAttributedString
}

final class OnboardSecondStepVC: UIViewController {
    private var viewModel: OnboardSecondStepViewModelProtocol
    
    private lazy var contentView: UIView = .contentView()
    private lazy var logoContainer = UIView()
    private lazy var logoImageView: UIImageView =
        .init(image: .General.logo)
    private lazy var titleLabel: UILabel =
        .titleLabel(.Onboarding.different_types)
    private lazy var infoView: UIView = .infoView()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        let atrString = viewModel.setAttributes(to:
                .Onboarding.you_can_use_three_types_of_notifications)
        label.attributedText = atrString
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var popupContainer = UIView()
    private lazy var popupImageView: UIImageView = .init(image: .Onboarding.popup)
    
    private lazy var calendarLabel: UILabel = .popupLabel(.Onboarding.calendar)
    private lazy var locationLabel: UILabel = .popupLabel(.Onboarding.location)
    private lazy var timerLabel: UILabel = .popupLabel(.Onboarding.timer)
    
    private lazy var doneButton: UIButton =
        .yellowRoundedButton(.Onboarding.done)
        .withAction(viewModel,
                    #selector(OnboardSecondStepViewModelProtocol.doneDidTap))
    
    init(viewModel: OnboardSecondStepViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.dismissedByUser()
    }
}

//MARK: - UI
private extension OnboardSecondStepVC {
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(infoLabel)
        contentView.addSubview(popupContainer)
        popupContainer.addSubview(popupImageView)
        popupImageView.addSubview(calendarLabel)
        popupImageView.addSubview(locationLabel)
        popupImageView.addSubview(timerLabel)
        view.addSubview(doneButton)
    }
    
    func setupLayout() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(doneButton.snp.centerY)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        popupContainer.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(infoView.snp.bottom)
            make.bottom.equalTo(doneButton.snp.top)
        }
        
        popupImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(157)
            make.width.equalTo(180)
        }
        
        calendarLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(26)
            make.trailing.equalToSuperview().inset(48)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(calendarLabel.snp.bottom).inset(-14)
            make.leading.equalTo(calendarLabel.snp.leading)
            make.trailing.equalTo(calendarLabel.snp.trailing)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(locationLabel.snp.bottom).inset(-12)
            make.leading.equalTo(calendarLabel.snp.leading)
            make.trailing.equalTo(calendarLabel.snp.trailing)
        }
        
        doneButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
