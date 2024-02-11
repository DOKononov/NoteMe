//
//  CommentTextView.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 10.02.24.
//

import UIKit
import SnapKit

final class CommentTextView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appBoldFont.withSize(13)
        label.textColor = .appText
        label.textAlignment = .left
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .appFont.withSize(15)
        textView.textColor = .appText
        textView.layer.borderColor = UIColor.appText.cgColor
        textView.layer.borderWidth = 1
        textView.delegate = self
        textView.textAlignment = .left
        return textView
    }()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var placeholder: String? { didSet { setPlaceholder() } }
    
    var text: String? {
        get { textView.text }
        set { textView.text = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4)
            make.height.equalTo(68)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
}

//MARK: -UITextViewDelegate
extension CommentTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            removePlaceholder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPlaceholder()
        }
    }
    
    private func setPlaceholder() {
        textView.text = placeholder
        textView.textColor = .secondaryLabel
    }
    
    private func removePlaceholder() {
        textView.text = nil
        textView.textColor = .label
    }
}
