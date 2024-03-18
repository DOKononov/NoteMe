//
//  ProfileCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 13.12.23.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    private var rootVC: UIViewController?
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }

    override func start() -> UIViewController {
        let vc = ProfileAssembler.make(self, container: container)
        rootVC = vc
        return vc
    }
}

//MARK: -ProfileCoordinatorProtocol
extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func openNotificationsMap() {
        let coordinator = NotificationsMapCoordinator(container: container)
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
