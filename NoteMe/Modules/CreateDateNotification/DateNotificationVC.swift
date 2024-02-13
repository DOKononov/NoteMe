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
    
    var title: String? { get set }
    var date: Date? { get set }
    var comment: String? { get set }
    func string(from date: Date?) -> String?
    
    func dismissDidTapped()
    func createDidTapped()
    
}

final class DateNotificationVC: UIViewController {
    private var viewModel: DateNotificationViewModelProtocol
    
    private lazy var contentView: UIView = .contentView()
    private lazy var titleLabel: UILabel =
        .notificationTitleLabel(
            .Notification.create_date_notification)
    
    private lazy var infoView: UIView = .infoView()
    
    private lazy var titleView: LineTextField = {
        let titleView = LineTextField()
        titleView.title = .Notification.title
        titleView.delegate = self
        titleView.placeholder = .Notification.enter_title
        return titleView
    }()
    
    private lazy var dateView: LineTextField = {
        let dateView = LineTextField()
        dateView.title = .Notification.date
        dateView.placeholder = .Notification.enter_date
        return dateView
    }()
    
    private lazy var commentView: CommentTextView = {
        let commentView = CommentTextView()
        commentView.title = .Notification.comment
        commentView.placeholder = .Notification.enter_comment
        commentView.delegate = self
        return commentView
    }()
    
    private lazy var createButton: UIButton =
        .yellowRoundedButton(.Notification.create)
        .withAction(self, #selector(createDidTapped))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(viewModel,
                    #selector(DateNotificationViewModelProtocol.dismissDidTapped))
    
    init(viewModel: DateNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    private func setupDatePickerInputView() {
        let datePicker = AppDatePickerView(.date)
        datePicker.delegate = self
        dateView.inputView = datePicker
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        setupDatePickerInputView()
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
        viewModel.createDidTapped()
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

//MARK: -LineTextFieldDelegate
extension DateNotificationVC: LineTextFieldDelegate {
    func lineTextFieldDidChangeSelection(_ lineTextField: LineTextField) {
        if lineTextField == titleView {
            viewModel.title = lineTextField.text
        }
    }
}

//MARK: -CommentTextViewDelegate
extension DateNotificationVC: CommentTextViewDelegate {
    func commentTextViewDidChangeSelection(_ commentTextView: CommentTextView) {
        viewModel.comment = commentTextView.text
    }
}

//MARK: -AppDatePickerViewDelegate
extension DateNotificationVC: AppDatePickerViewDelegate {
    func datePickerValueChanged(date: Date?) {
        viewModel.date = date
        dateView.text = viewModel.string(from: date)
    }
    
    func cancelDidTapped() {
        view.endEditing(true)
    }
    
    func selectDidTapped() {
        view.endEditing(true)
    }
}
