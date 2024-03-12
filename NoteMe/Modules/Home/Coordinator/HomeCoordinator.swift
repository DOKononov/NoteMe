//
//  HomeCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 12.12.23.
//

import UIKit
import Storage

final class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {

    private var rootVC: UIViewController?
    
    private let container: Container
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc = HomeAssembler.make(coordinator: self, container: container)
        rootVC = vc
        return vc
    }
    
    func startEdite(date dto: DateNotificationDTO) {
        let coordinator = DateNotificationCoordinator(
            container: container,
            dto: dto)
        chidren.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { coordinator == $0 }
            vc.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
    func startEdite(location dto: Storage.LocationNotificationDTO) {
        let coordinator = LocationNotificationCoordinator(
            container: container,
            dto: dto)
        chidren.append(coordinator)
        let vc = coordinator.start()
        
        coordinator.onDidFinish = { [weak self] coordinator in
            self?.chidren.removeAll { coordinator == $0 }
            vc.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
    }
    
    func showMenu(_ sender: UIView, delegate: MenuPopoverDelegate) {
        let menu = MenuPopoverBuilder.buildEditeenu(delegate: delegate,
                                                    sourceView: sender)
        rootVC?.present(menu, animated: true)
    }
    
}
