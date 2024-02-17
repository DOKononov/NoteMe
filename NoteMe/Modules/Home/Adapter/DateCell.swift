//
//  DateCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 15.02.24.
//

import UIKit
import Storage
import SnapKit

final class DateCell: UITableViewCell {
    
    
    private lazy var iconView: UIView = {
       let view = UIView()
        view.backgroundColor = .appBlack
        view.layer.cornerRadius = 5
        return view
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
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 3)
        button.setImage(.MainTabBar.settings, for: .normal)
        button.setImage(.MainTabBar.calendar, for: .highlighted)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        settingsButton.addTarget(self, action: #selector(settingsDidTapped), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    func config(for dto: DateNotificationDTO) {
        title.text = dto.title
        subTitle.text = dto.subtitle
    }
    
   @objc private func settingsDidTapped() {
       print("tap")
   }
    
    
    private func setupUI() {
        addSubview(iconView)
        addSubview(title)
        addSubview(subTitle)
        addSubview(settingsButton)
        backgroundColor = .appCellBackground


        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.verticalEdges.equalToSuperview().inset(16)
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
