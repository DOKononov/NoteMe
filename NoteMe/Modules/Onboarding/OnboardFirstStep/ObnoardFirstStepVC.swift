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
        view.backgroundColor = .appGray
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        nextButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
}
