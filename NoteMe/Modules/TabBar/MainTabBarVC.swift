//
//  MainTabBarVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 29.11.23.
//

import UIKit

protocol MainTabBarViewModelProtocol: PopoverVCDelegate { }
final class MainTabBarVC: UITabBarController {
    private var viewModel: MainTabBarViewModelProtocol
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(.General.tabBarAddButton, for: .normal)
        button.addTarget(self, action: #selector(addButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: MainTabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: -private methods
private extension MainTabBarVC {
    @objc func addButtonDidPressed() {
        let vc = PopoverVC.make(type: .create, for: addButton)
        vc.delegate = viewModel
        present(vc, animated: true)
    }
}

//MARK: -setupUI
private extension MainTabBarVC {
    func setupUI() {
        view.addSubview(addButton)
        
        tabBar.tintColor = .appYellow
//        tabBar.backgroundColor = .appBlack
        tabBar.unselectedItemTintColor = .appGray
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBlack
        tabBar.standardAppearance = appearance
        
        
        addButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tabBar.snp.top)
        }
    }
}

