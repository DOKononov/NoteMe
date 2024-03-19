//
//  TimerNotificationAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import Storage

final class TimerNotificationAssembler {
    private init() {}
    
    static func make(_ coordinator: TimerNotificationCoordinatorProtocol,
                     container: Container,
                     dto: TimerNotificationDTO?) -> UIViewController {
        let storage: TimerNotificationStorage = container.resolve()
        let notificationService: NotificationService = container.resolve()
        let vm = TimerNotificationVM(
            coordinator: coordinator,
            storage: storage,
            notificationService: notificationService, dto: dto)
        let vc = TimerNotificationVC(viewModel: vm)
        return vc
    }
}
