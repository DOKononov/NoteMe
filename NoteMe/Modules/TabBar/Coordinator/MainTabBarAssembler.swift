//
//  MainTabBarAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class MainTabBarAssembler {
    private init() {}
    
    static func make() -> UITabBarController {
//        let tabBar = MainTabBarVC()
//
//        let homeVC = UIViewController()
//        homeVC.view.backgroundColor = .cyan
//
//        let profileVC = UIViewController()
//        profileVC.view.backgroundColor = .red
//
//        tabBar.viewControllers = [homeVC, profileVC]
        
        return MainTabBarVC()
    }
}
