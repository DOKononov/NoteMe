//
//  NotificationsMapCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 18.03.24.
//

import UIKit
import Storage

final class NotificationsMapCoordinator: Coordinator, NotificationsMapCoordinatorProtocol {
    
    private let container: Container
    private var rootVC: UIViewController?

    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc =  NotificationsMapAssembler.make(self)
        rootVC = vc
        return vc
    }
    
    func startEdite(location dto: LocationNotificationDTO) {
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
}
