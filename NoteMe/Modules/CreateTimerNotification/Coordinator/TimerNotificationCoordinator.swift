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
        if let dto {
            let vc = TimerNotificationAssembler.makeEdit(
                self,
                container: container,
                dto: dto
            )
            rootVC = vc
            return vc
        } else {
            let vc = TimerNotificationAssembler.makeCreate(
                self,
                container: container
            )
            rootVC = vc
            return vc
        }
    }
}

extension TimerNotificationCoordinator: TimerNotificationCoordinatorProtocol {}
