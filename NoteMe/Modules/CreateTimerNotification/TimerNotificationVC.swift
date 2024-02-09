//
//  TimerNotificationVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

@objc protocol TimerNotificationViewModelProtocol: AnyObject {
    func dismissDidTapped()
}

final class TimerNotificationVC: UIViewController {
    
    private var viewModel: TimerNotificationViewModelProtocol
    private lazy var contentView: UIView = .contentView()
    private lazy var titleLabel: UILabel = 
        .notificationTitleLabel(
        .TimerNotification.create_timer_notification)
    private lazy var infoView: UIView = .infoView()
    
    private lazy var createButton: UIButton =
        .yellowRoundedButton(.TimerNotification.create)
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(viewModel,
                    #selector(TimerNotificationViewModelProtocol.dismissDidTapped))
    
    
    init(viewModel: TimerNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


private extension TimerNotificationVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        view.addSubview(createButton)
        view.addSubview(cancelButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(createButton.snp.centerY)
        }

        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
            make.bottom.equalTo(infoView.snp.top).inset(-10)
        }
   
        infoView.snp.makeConstraints { make in
            make.height.equalTo(150) //TODO: delete
            make.horizontalEdges.equalToSuperview().inset(16)
        }


        
        
        
        
        createButton.snp.makeConstraints { make in
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
