//
//  AppTabBar.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 29.11.23.
//

import UIKit

final class AppTabBar: UITabBarController {
    
    private lazy var homeVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .darkGray
        vc.tabBarItem = UITabBarItem(title: "Home",
                                     image: .init(systemName: "house"),
                                     selectedImage: .init(systemName: "house"))
        return vc
    }()
    
    private lazy var profileVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .lightGray
        vc.tabBarItem = UITabBarItem(title: "Profile",
                                     image: .init(systemName: "person.fill"),
                                     selectedImage: .init(systemName: "person.fill"))
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [homeVC, profileVC]
        tabBar.tintColor = .appYellow
        tabBar.unselectedItemTintColor = .appGray
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .appBlack
    }
}
