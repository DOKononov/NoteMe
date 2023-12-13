//
//  HomeVC.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit



final class HomeVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .appGray
    }
    
    private func setupTabBarItem() {
        //TODO: locolize
        self.tabBarItem = UITabBarItem(title: "Home",
                                      image: UIImage(systemName: "homekit"),
                                      tag: .zero)
        
    }
}
