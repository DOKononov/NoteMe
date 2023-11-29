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
}

final class OnboardSecondStepVC: UIViewController {
    
    private var viewModel: OnboardSecondStepViewModelProtocol
    
    private lazy var doneButton: UIButton =
        .yellowRoundedButton(.Onboarding.done)
        .withAction(viewModel, #selector(OnboardSecondStepViewModelProtocol.doneDidTap))
    
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
        view.backgroundColor = .appGray
        view.addSubview(doneButton)
    }
    
    func setupLayout() {
        doneButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
}
