//
//  PopoverCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 11.02.24.
//

import UIKit
import SnapKit

final class PopoverCell: UITableViewCell {
    
    private let cellTitleLable: UILabel = {
       let label = UILabel()
        label.font = .appFont.withSize(16)
        label.textColor = .label
        return label
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    func configCell(for row: PopoverRow) {
        self.cellImageView.image = row.image
        self.cellTitleLable.text = row.title
    }
    
    
    private func setupUI() {
        addSubview(cellTitleLable)
        addSubview(cellImageView)
        
        cellTitleLable.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        cellImageView.snp.makeConstraints { make in
            make.leading.equalTo(cellTitleLable.snp.trailing).inset(8)
            make.verticalEdges.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
