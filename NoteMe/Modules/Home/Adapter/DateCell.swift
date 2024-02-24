//
//  DateCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 17.02.24.
//

import UIKit
import Storage
import SnapKit

final class DateCell: UITableViewCell {
    
    var buttonDidTapped: ((_ sender: UIButton) -> Void)?
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBlack
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont.withSize(25)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .appYellow
        return label
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(15)
        label.textAlignment = .center
        label.textColor = .white
        return label
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
    
    func config(for dto: DateNotificationDTO) {
        title.text = dto.title
        subTitle.text = dto.subtitle
        set(date: dto.targetDate)
    }
    
    private func set(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        dateLabel.text = formatter.string(from: date)
        formatter.dateFormat = "MMM"
        monthLabel.text = formatter.string(from: date)
    }
    
    @objc private func settingsDidTapped(sender: UIButton) {
        buttonDidTapped?(sender)
    }
    
    private func setupUI() {
        addSubview(iconView)
        iconView.addSubview(dateLabel)
        iconView.addSubview(monthLabel)
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
        
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(11)
            make.top.equalToSuperview().inset(4)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).inset(5)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(4)
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
