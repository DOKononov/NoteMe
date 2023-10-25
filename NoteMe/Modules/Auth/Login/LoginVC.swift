//
//  LoginVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 24.10.23.
//

import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: .General.logo)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    
    private func setupUI() {
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        contentView.addSubview(logoImageView)
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(72)
            make.size.equalTo(96)
        }
    }
}
