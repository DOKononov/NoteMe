//
//  LocationNotificationVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import SnapKit
import Storage

 protocol LocationNotificationViewModelProtocol: AnyObject {
    var title: String? {get set}
    var comment: String? {get set}
    var imageDidSet: ((UIImage?)-> Void)? {get set}
    var catchTitleError: ((String?) -> Void)? {get set}
    var shouldEditeDTO: ((LocationNotificationDTO) -> Void)? {get set}

    func dismissDidTap()
    func mapDidTap()
    func createDidTap()
    func viewDidLoad()
    
}

final class LocationNotificationVC: UIViewController {
    
    private enum Const {
        static let imageViewHeight: CGFloat = 147
        static let buttonHeight: CGFloat = 45
    }
    
    private var viewModel: LocationNotificationViewModelProtocol
    private lazy var contentView: UIView = .contentView()
    private lazy var titleLabel: UILabel =
        .notificationTitleLabel(.Notification.create_location_notification)
    private lazy var infoView: UIView = .infoView()
    
    private lazy var titleView: LineTextField = {
        let titleView = LineTextField()
        titleView.title = .Notification.title
        titleView.delegate = self
        titleView.placeholder = .Notification.enter_title
        return titleView
    }()
    
    private lazy var commentView: CommentTextView = {
        let commentView = CommentTextView()
        commentView.title = .Notification.comment
        commentView.placeholder = .Notification.enter_comment
        commentView.delegate = self
        return commentView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = .MainTabBar.location
        label.font = .appBoldFont.withSize(13)
        label.textColor = .label
        return label
    }()
    
    
    private lazy var addLocationButton: UIButton =
        .yellowRoundedButton(.Map.add_location)
        .withAction(self, #selector(mapDidTap))
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(mapDidTap)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var createButton: UIButton =
        .yellowRoundedButton(.Notification.create)
        .withAction(self, #selector(createDidTap))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(self, #selector(dismissDidTap))
    
    
    init(viewModel: LocationNotificationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.viewDidLoad()
    }
    
    private func bind() {
        viewModel.imageDidSet = { [weak self] image in
            if let image {
                self?.addLocationButton.isHidden = true
                self?.imageView.isHidden = false
                self?.imageView.image = image
            } else {
                self?.addLocationButton.isHidden = false
                self?.imageView.isHidden = true
            }
            self?.addLocationButton.snp.updateConstraints { $0.height.equalTo((image == nil) ? Const.buttonHeight : .zero) }
            self?.imageView.snp.updateConstraints { $0.height.equalTo((image == nil) ? .zero : Const.imageViewHeight) }
        }
        
        viewModel.catchTitleError = { [weak titleView] error in
            titleView?.errorText = error
        }
        
        viewModel.shouldEditeDTO = { [weak self] dto in
            self?.titleView.text = dto.title
            self?.viewModel.title = dto.title
            self?.commentView.text = dto.subtitle
            self?.viewModel.comment = dto.subtitle
            self?.createButton.setTitle(.MainTabBar.edit, for: .normal)
        }
    }
}


private extension LocationNotificationVC {
    func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoView)
        infoView.addSubview(titleView)
        infoView.addSubview(commentView)
        infoView.addSubview(locationLabel)
        infoView.addSubview(addLocationButton)
        infoView.addSubview(imageView)
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
        
        commentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(titleView.snp.bottom).inset(-16)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(commentView.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        addLocationButton.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(Const.buttonHeight)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(addLocationButton.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(Const.imageViewHeight)
            make.bottom.equalToSuperview().inset(16)
        }

        createButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(Const.buttonHeight)
            make.bottom.equalTo(cancelButton.snp.top).inset(-8)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(Const.buttonHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func mapDidTap() {
        viewModel.mapDidTap()
    }
    
    @objc private func createDidTap() {
        viewModel.createDidTap()
    }
    
    @objc private func dismissDidTap() {
        viewModel.dismissDidTap()
    }
    
}

extension LocationNotificationVC: LineTextFieldDelegate {
    func lineTextFieldDidChangeSelection(_ lineTextField: LineTextField) {
        if lineTextField == titleView {
            viewModel.title = lineTextField.text
        }
    }
}


extension LocationNotificationVC: CommentTextViewDelegate {
    func commentTextViewDidChangeSelection(_ commentTextView: CommentTextView) {
        if commentTextView == commentView {
            viewModel.comment = commentTextView.text
        }
    }
}
