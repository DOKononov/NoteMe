//
//  TimerNotificationCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

final class TimerNotificationCoordinator: Coordinator {
    private var rootVC: UIViewController?
    
    override func start() -> UIViewController {
        let vc = TimerNotificationAssembler.make(self)
        rootVC = vc
        return vc
    }
    
}

extension TimerNotificationCoordinator: TimerNotificationCoordinatorProtocol {
    
}
