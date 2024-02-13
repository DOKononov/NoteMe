//
//  TimerNotificationVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

protocol TimerNotificationViewModelProtocol: AnyObject {
    var title: String? { get set }
    var comment: String? { get set }
    var timeinterval: Double? { get set }
    func dismissDidTapped()
    func createDidTapped()
}

final class TimerNotificationVC: UIViewController {
    
    private var viewModel: TimerNotificationViewModelProtocol
    private lazy var contentView: UIView = .contentView()
    private lazy var titleLabel: UILabel = 
        .notificationTitleLabel(
        .Notification.create_timer_notification)
    private lazy var infoView: UIView = .infoView()
    
    private lazy var titleView: LineTextField = {
       let titleView = LineTextField()
        titleView.title = .Notification.title
        titleView.placeholder = .Notification.enter_title
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var timerView: LineTextField = {
        let timerView = LineTextField()
        timerView.title = .Notification.timer
        timerView.placeholder = .Notification.enter_timer
        return timerView
    }()
    
    private lazy var commentView: CommentTextView = {
       let commentView = CommentTextView()
        commentView.delegate = self
        commentView.title = .Notification.comment
        commentView.placeholder = .Notification.enter_comment
        return commentView
    }()
    
    private lazy var createButton: UIButton =
        .yellowRoundedButton(.Notification.create)
        .withAction(self, #selector(createDidTapped))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(self, #selector(dismissDidTapped))
    
    
    init(viewModel: TimerNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func dismissDidTapped() {
        viewModel.dismissDidTapped()
    }
    
    @objc private func createDidTapped() {
        viewModel.createDidTapped()
    }
}


private extension TimerNotificationVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(titleView)
        infoView.addSubview(timerView)
        infoView.addSubview(commentView)
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
            make.horizontalEdges.equalToSuperview().inset(16)
        }

        titleView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
        }
        
        timerView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        commentView.snp.makeConstraints { make in
            make.top.equalTo(timerView.snp.bottom).inset(-16)
            make.horizontalEdges.bottom.equalToSuperview().inset(16)
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


extension TimerNotificationVC: LineTextFieldDelegate {
    func lineTextFieldDidChangeSelection(_ lineTextField: LineTextField) {
        
    }
    
    
}


extension TimerNotificationVC: CommentTextViewDelegate {
    func commentTextViewDidChangeSelection(_ commentTextView: CommentTextView) {
         
    }
    
    
}
