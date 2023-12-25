//
//  ProfileAccountCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.12.23.
//

import UIKit

final class ProfileAccountCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .appCellTitleText
        label.font = .appFont.withSize(15)
        label.text = .Profile.your_email
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(17)
        label.textColor = .appText
        return label
    }()
    
    var email: String? {
        get { emailLabel.text }
        set { emailLabel.text = newValue }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(emailLabel)
        
        layer.cornerRadius = 5
        self.clipsToBounds = true
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(17)
            make.top.equalToSuperview().inset(16)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).inset(-4)
        }
    }
}
