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
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .appCellSeparator
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configCell(for button: ProfileCellEntity,
                    for indexPath: IndexPath,
                    in tableView: UITableView) {
        titleLabel.text = button.title
        iconImageView.image = button.image
        statusLabel.text = button.status
        setCorners(for: indexPath, in: tableView)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func setCorners(for indexPath: IndexPath, in tableView: UITableView) {
        let isFirst = indexPath.row == 0
        let isLast = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
       cornerRadius = 5
       layer.maskedCorners = []
       clipsToBounds = true
       
        if isFirst && isLast {
            self.layer.maskedCorners = [.layerMaxXMinYCorner,
                                        .layerMinXMinYCorner,
                                        .layerMinXMaxYCorner,
                                        .layerMaxXMaxYCorner]
        } else if isFirst {
            self.layer.maskedCorners = [.layerMaxXMinYCorner,
                                        .layerMinXMinYCorner]
        } else if isLast {
            self.layer.maskedCorners = [.layerMinXMaxYCorner,
                                        .layerMaxXMaxYCorner]
            titleLabel.textColor = .appRed
            separator.isHidden = true
        }
    }
}

//MARK: - UI
private extension ProfileSettingsCell {
    
    func setupUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(separator)
        
        separatorInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).inset(-8)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        separator.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
