//
//  LocationCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.02.24.
//

import UIKit
import Storage

final class LocationCell: UITableViewCell {
    
    var buttonDidTapped: ((_ sender: UIButton) -> Void)?
    private let imageStorage = ImageStorageWorker( //TODO: fix
        cloudStorage: FirebaseStorageService(),
        localStorage: ImageStorage())
    
    private lazy var cellContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .itemBackground
        view.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBlack
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var iconImageView: UIView = {
        let imageView = UIImageView(image: .MainTabBar.location)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .appBoldFont.withSize(15)
        label.textColor = .label
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 3)
        button.setImage(.MainTabBar.settings, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(settingsDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "photo"))
        imageView.tintColor = .label
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    func config(for dto: LocationNotificationDTO) {
        title.text = dto.title
        subTitle.text = dto.subtitle
        imageStorage.download(id: dto.id) { [weak self] image in
            DispatchQueue.main.async {
                self?.locationImageView.image = image
            }
        }
    }
    
    
    @objc private func settingsDidTapped(sender: UIButton) {
        buttonDidTapped?(sender)
    }
    
    private func setupUI() {
        addSubview(cellContentView)
        cellContentView.addSubview(iconView)
        iconView.addSubview(iconImageView)
        cellContentView.addSubview(title)
        cellContentView.addSubview(subTitle)
        cellContentView.addSubview(settingsButton)
        cellContentView.addSubview(locationImageView)
        contentView.isUserInteractionEnabled = false
        backgroundColor = .clear
        
        cellContentView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.top.equalToSuperview().inset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(13)
            make.verticalEdges.equalToSuperview().inset(8)
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).inset(-8)
            make.top.equalToSuperview().inset(16)
            make.trailing.equalTo(settingsButton.snp.leading).inset(-8)
        }
        
        subTitle.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).inset(-8)
            make.top.equalTo(title.snp.bottom).inset(-4)
            make.trailing.equalTo(settingsButton.snp.leading).inset(-8)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(147)
            make.top.equalTo(iconView.snp.bottom).inset(-8)
            make.bottom.equalToSuperview().inset(16)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.size.equalTo(18)
        }
    }
}
