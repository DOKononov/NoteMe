//
//  AppDatePickerView.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 30.10.23.
//

import UIKit
import SnapKit

protocol AppDatePickerViewDelegate: AnyObject {
    func datePickerValueChanged(date: Date?)
    func cancelDidTapped()
    func selectDidTapped()
}

final class AppDatePickerView: UIView {
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitleColor(.appYellow.withAlphaComponent(0.7), for: .highlighted)
        button.titleLabel?.font = .appFont.withSize(15)
        button.addTarget(self, action: #selector(cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select", for: .normal)
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitleColor(.appYellow.withAlphaComponent(0.7), for: .highlighted)
        button.titleLabel?.font = .appBoldFont.withSize(15)
        button.addTarget(self, action: #selector(selectButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()
    
    weak var delegate: AppDatePickerViewDelegate?
    
    init(_ datePickerMode: UIDatePicker.Mode) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 280))
        datePicker.datePickerMode = datePickerMode
        setupUI()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

//MARK: -private methods
extension AppDatePickerView {
    @objc private func cancelButtonDidPressed() {
        delegate?.cancelDidTapped()
    }
    
    @objc private func selectButtonDidPressed() {
        delegate?.selectDidTapped()
    }
    
    @objc private func datePickerValueChanged(sender: UIDatePicker) {
        delegate?.datePickerValueChanged(date: sender.date)
    }
}


//MARK: -setupUI

extension AppDatePickerView {
    private func setupUI() {
        backgroundColor = .appBlack
        addSubview(datePicker)
        addSubview(cancelButton)
        addSubview(selectButton)
    }
    
    private func setupLayouts() {
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(17)
            make.top.equalToSuperview().inset(14)
        }
        
        selectButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(17)
            make.top.equalToSuperview().inset(14)
        }
        
        datePicker.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().inset(45)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
