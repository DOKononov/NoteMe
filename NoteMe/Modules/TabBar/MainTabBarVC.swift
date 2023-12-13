//
//  MainTabBarVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 29.11.23.
//

import UIKit

final class MainTabBarVC: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .appYellow
        
        tabBar.backgroundColor = .appBlack
        tabBar.unselectedItemTintColor = .appGray
    }
}
