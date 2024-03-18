//
//  NotificationsMapCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 18.03.24.
//

import UIKit

final class NotificationsMapCoordinator: Coordinator, NotificationsMapCoordinatorProtocol {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    override func start() -> UIViewController {
        let vc =  NotificationsMapAssembler.make(self)
        return vc
    }
}
