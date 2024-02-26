//
//  AppTimerPickerView.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.02.24.
//

import UIKit
import SnapKit

protocol AppTimerPickerViewDelegate: AnyObject {
    func pickerValueChanged(timeInterval: TimeInterval)
    func cancelDidTapped()
    func selectDidTapped()
}

final class AppTimerPickerView: UIView {
    
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
        datePicker.datePickerMode = .countDownTimer
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
        return datePicker
    }()
    
    weak var delegate: AppTimerPickerViewDelegate?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 280))
        setupUI()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

//MARK: -private methods
extension AppTimerPickerView {
    @objc private func cancelButtonDidPressed() {
        delegate?.cancelDidTapped()
    }
    
    @objc private func selectButtonDidPressed() {
        delegate?.selectDidTapped()
    }
    
    @objc private func pickerValueChanged(sender: UIDatePicker) {
        delegate?.pickerValueChanged(timeInterval: sender.countDownDuration)
    }
}


//MARK: -setupUI

extension AppTimerPickerView {
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

