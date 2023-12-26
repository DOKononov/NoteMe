//
//  MainTabBarVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 29.11.23.
//

import UIKit

final class MainTabBarVC: UITabBarController {
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(.General.tabBarAddButton, for: .normal)
        button.addTarget(self,
                         action: #selector(addButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: -private methods
private extension MainTabBarVC {
    @objc func addButtonDidPressed() {}
}

//MARK: -setupUI
private extension MainTabBarVC {
    func setupUI() {
        tabBar.tintColor = .appYellow
        tabBar.backgroundColor = .appBlack
        tabBar.unselectedItemTintColor = .appGray
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tabBar.snp.top)
        }
    }
}

