//
//  MenuActionCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 27.02.24.
//

import UIKit
import SnapKit

protocol MenuActionItem {
    var title: String { get }
    var icon: UIImage? { get }
}

final class MenuActionCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
     let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.font = .appFont.withSize(16)
        return label
    }()
    
    private lazy var iconView = UIImageView()
    
    func setup(_ item: MenuActionItem) {
        titleLabel.text = item.title
        iconView.image = item.icon
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
