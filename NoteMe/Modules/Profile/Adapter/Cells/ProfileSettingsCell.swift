//
//  ProfileSettingsCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.12.23.
//

import UIKit
import SnapKit

final class ProfileSettingsCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(14)
        label.textColor = .appText
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(12)
        label.textColor = .appCellStatusText
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setup(_ type: ProfileSttingsRows) {
        titleLabel.text = type.title
        iconImageView.image = type.icon
        titleLabel.textColor = type == .logout ? .appRed : .appText
        statusLabel.text = type.subTitle
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

//MARK: - UI
private extension ProfileSettingsCell {
    
    func setupUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(statusLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).inset(-8)
            make.verticalEdges.equalToSuperview().inset(12)
        }
    }
}
