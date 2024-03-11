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
        let tabbar =  MainTabBarAssembler.make(coordinator: self)
        tabbar.viewControllers = [makeHomeModule(), makeProfileModule()]
        rootVC = tabbar
        return tabbar
    }
    
    private func makeHomeModule() -> UIViewController {
        let coordinator = HomeCoordinator(container: container)
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


extension MainTabBarCoordinator: MainTabBarCoordinatorProtocol {
    func showMenu(sender: UIView, delegate: MenuPopoverDelegate) {
        let menu = MenuPopoverBuilder.buildAddMenu(delegate: delegate,
                                                   sourceView: sender)
        rootVC?.present(menu, animated: true)
    }

    
    func openNewDateNotification() {
            let coodinator = DateNotificationCoordinator(container: container)
            chidren.append(coodinator)
            let vc = coodinator.start()
            
            coodinator.onDidFinish = { [weak self] cordinator in
                self?.chidren.removeAll { coodinator == $0 }
                vc.dismiss(animated: true)
            }
            vc.modalPresentationStyle = .fullScreen
            rootVC?.present(vc, animated: true)
    }
    
    func openNewTimerNotification() {
        let coordinator = TimerNotificationCoordinator(container: container)
        chidren.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] cordinator in
            self?.chidren.removeAll { cordinator == $0 }
            vc.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
    func openNewLocationNotification() {
        let coodinator = LocationNotificationCoordinator(container: container,
                                                         dto: nil)
        chidren.append(coodinator)
        let vc = coodinator.start()
        
        coodinator.onDidFinish = { [weak self] cordinator in
            self?.chidren.removeAll { coodinator == $0 }
            vc.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true) 
    }
}
