//
//  DateNotificationCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

final class DateNotificationCoordinator: Coordinator {
    private var rootVC: UIViewController?

    override func start() -> UIViewController {
        let vc = DateNotificationAssembler.make(self)
        rootVC = vc
        return vc
    }
}

extension DateNotificationCoordinator: DateNotificationCoordinatorProtocol {
    
}
