//
//  DateNotificationVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import SnapKit

@objc protocol DateNotificationViewModelProtocol: AnyObject {
    var catchTitleError: ((String?) -> Void)? { get set }
    var catchDateError: ((String?) -> Void)? { get set }
    
    func dismissDidTapped()
    func createDidTapped(title: String?, date: Date?, comment: String?)
    
}

final class DateNotificationVC: UIViewController {
    private var viewModel: DateNotificationViewModelProtocol
    
    private lazy var contentView: UIView = .contentView()
    private lazy var titleLabel: UILabel =
        .notificationTitleLabel(
            .DateNotification.create_date_notification)
    
    private lazy var infoView: UIView = .infoView()
    
    private lazy var titleView: LineTextField = {
       let titleView = LineTextField()
        titleView.title = .DateNotification.title
        titleView.placeholder = .DateNotification.enterTitle
        return titleView
    }()
    
    private lazy var dateView: LineTextField = {
       let dateView = LineTextField()
        dateView.title = .DateNotification.date
        
        dateView.placeholder = .DateNotification.enterDate
        return dateView
    }()
    
    private lazy var commentView: CommentTextView = {
       let titleView = CommentTextView()
        titleView.title = .DateNotification.comment
        titleView.placeholder = .DateNotification.enterComment
        return titleView
    }()
    
    private lazy var createButton: UIButton =
        .yellowRoundedButton(.DateNotification.create)
        .withAction(self, #selector(createDidTapped))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(viewModel,
                    #selector(DateNotificationViewModelProtocol.dismissDidTapped))
    
    init(viewModel: DateNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func bind() {
        viewModel.catchDateError = { [weak self] error in
            self?.dateView.errorText = error
        }
        
        viewModel.catchTitleError = { [weak self] error in
            self?.titleView.errorText = error
        }
    }
    
    @objc private func createDidTapped() {
        viewModel.createDidTapped(title: titleView.text,
                                  date: nil, //TODO
                                  comment: commentView.text)
    }
}

//MARK: -setupUI
private extension DateNotificationVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(titleView)
        infoView.addSubview(dateView)
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
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        dateView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(titleView.snp.bottom).inset(-16)
        }
        
        commentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(dateView.snp.bottom).inset(-16)
            make.bottom.equalToSuperview().inset(16)
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
