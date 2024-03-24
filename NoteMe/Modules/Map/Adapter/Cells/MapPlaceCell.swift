//
//  MapPlaceCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 23.03.24.
//

import UIKit
import SnapKit

final class MapPlaceCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = .appFont.withSize(13)
        label.textColor = .label
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont.withSize(12)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
       let label = UILabel()
        label.font = .appFont.withSize(11)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    func confiCell(for place: Place) {
        titleLabel.text = place.name
        distanceLabel.text = "\(place.distance) meters" //TODO: fix
        addressLabel.text = place.address
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(addressLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.width.equalTo(titleLabel.snp.width)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).inset(-8)
        }
    }
}
