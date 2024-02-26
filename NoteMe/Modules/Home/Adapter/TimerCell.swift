//
//  TimerCell.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.02.24.
//

import UIKit
import Storage

final class TimerCell: UITableViewCell {
    
    var buttonDidTapped: ((_ sender: UIButton) -> Void)?
    private var dto: TimerNotificationDTO?
    
    private var countdownDuration: Double = 0 {
        didSet {
            strFromTimeinterval()
        }
    }
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBlack
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var iconImageView: UIView = {
        let imageView = UIImageView(image: .MainTabBar.timer)
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont.withSize(29)
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
        runTimer()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        runTimer()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    func config(for dto: TimerNotificationDTO) {
        title.text = dto.title
        subTitle.text = dto.subtitle
        self.dto = dto
        self.countdownDuration = dto.timeLeft
    }
    

    
    private func strFromTimeinterval() {
        if countdownDuration >= 0 {
            let time = NSInteger(countdownDuration)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)
            timerLabel.text = String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        } else {
            timerLabel.text = "00:00:00"
        }
    }
    
    private func runTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard
                let timeLeft = self?.dto?.timeLeft,
                timeLeft >= 0 else {
                timer.invalidate()
                return
            }
            self?.countdownDuration = timeLeft
        }
    }
    
    
    @objc private func settingsDidTapped(sender: UIButton) {
        buttonDidTapped?(sender)
    }
    
    private func setupUI() {
        addSubview(iconView)
        iconView.addSubview(iconImageView)
        addSubview(title)
        addSubview(subTitle)
        addSubview(timerLabel)
        addSubview(settingsButton)
        accessoryView = settingsButton
        cornerRadius = 5
        clipsToBounds = true
        
        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.top.equalToSuperview().inset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(9)
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
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(111)
            make.bottom.equalToSuperview().inset(17)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.size.equalTo(18)
        }
    }
}
