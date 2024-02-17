//
//  ProfileTableViewHeader.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 21.12.23.
//

import UIKit
import SnapKit

final class ProfileTableViewHeader: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .appBoldFont.withSize(14)
        return label
    }()
    
    var text: String? {
        get { titleLabel.text}
        set { titleLabel.text = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
