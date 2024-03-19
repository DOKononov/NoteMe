//
//  TimerNotificationCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import Storage

final class TimerNotificationCoordinator: Coordinator {
    private var rootVC: UIViewController?
    private let container: Container
    private let dto: TimerNotificationDTO?
    
    init(container: Container,
         dto: TimerNotificationDTO?) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        let vc = TimerNotificationAssembler.make(self,
                                                 container: container,
                                                 dto: dto)
        rootVC = vc
        return vc
    }
    
}

extension TimerNotificationCoordinator: TimerNotificationCoordinatorProtocol {
    
}
