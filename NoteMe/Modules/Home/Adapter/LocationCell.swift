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
    
    private var countdownDuration: Double = 0
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    func config(for dto: LocationNotificationDTO) {
        title.text = "Location Cell prototipe"
        subTitle.text = "Subtitle placeholder"
    }
    
    
    @objc private func settingsDidTapped(sender: UIButton) {
        buttonDidTapped?(sender)
    }
    
    private func setupUI() {
        addSubview(iconView)
        iconView.addSubview(iconImageView)
        addSubview(title)
        addSubview(subTitle)
        addSubview(settingsButton)
        accessoryView = settingsButton
        cornerRadius = 5
        clipsToBounds = true
        
        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.verticalEdges.equalToSuperview().inset(16)
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
        
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.size.equalTo(18)
        }
    }
}
