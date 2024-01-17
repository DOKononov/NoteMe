//
//  MainTabBarCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let tabbar =  MainTabBarAssembler.make()
        tabbar.viewControllers = [makeHomeModule(), makeProfileModule()]
        rootVC = tabbar
        return tabbar
    }
    
    private func makeHomeModule() -> UIViewController {
        let coordinator = HomeCoordinator()
        chidren.append(coordinator)
        return coordinator.start()
    }
    
    private func makeProfileModule() -> UIViewController {
        let coordinator = ProfileCoordinator(container: container)
        chidren.append(coordinator)
        let vc = coordinator.start()
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll()
            self?.rootVC?.dismiss(animated: true)
            self?.finish()
        }
        return vc
    }
}
