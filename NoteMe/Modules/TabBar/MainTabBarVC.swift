//
//  MainTabBarVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 29.11.23.
//

import UIKit

protocol MainTabBarViewModelProtocol {
    func makeDateNotification()
    func makeLocationNotification()
    func makeTimerNotification()
}
final class MainTabBarVC: UITabBarController {
    private var viewModel: MainTabBarViewModelProtocol
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(.General.tabBarAddButton, for: .normal)
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
    @objc func addButtonDidPressed() {}
    func setupMenu() {
        let calendar = UIAction(title: .MainTabBar.calendar,
                                image: UIImage.MainTabBar.calendar) { [weak self] _ in
            self?.viewModel.makeDateNotification()
        }
        let location = UIAction(title: .MainTabBar.location,
                                image: UIImage.MainTabBar.location) { [weak self] _ in
            self?.viewModel.makeLocationNotification()
        }
        let timer = UIAction(title: .MainTabBar.timer,
                             image: UIImage.MainTabBar.timer) { [weak self] _ in
            self?.viewModel.makeTimerNotification()
        }
        
        let menu = UIMenu(children: [timer, location, calendar])
        addButton.menu = menu
        addButton.showsMenuAsPrimaryAction = true
    }
}

//MARK: -setupUI
private extension MainTabBarVC {
    func setupUI() {
        view.addSubview(addButton)
        
        tabBar.tintColor = .appYellow
        tabBar.backgroundColor = .appBlack
        tabBar.unselectedItemTintColor = .appGray
        
        setupMenu()

        addButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tabBar.snp.top)
        }
    }
}

