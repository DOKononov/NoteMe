//
//  MainTabBarCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    override func start() -> UIViewController {
        let tabbar =  MainTabBarAssembler.make()
        tabbar.viewControllers = [makeHomeModule(), makeProfileModule()]
        return tabbar
    }
    
    private func makeHomeModule() -> UIViewController {
        let coordinator = HomeCoordinator()
        chidren.append(coordinator)
        return coordinator.start()
    }
    
    private func makeProfileModule() -> UIViewController {
        let coordinator = ProfileCoordinator()
        chidren.append(coordinator)
        return coordinator.start()
    }
}
