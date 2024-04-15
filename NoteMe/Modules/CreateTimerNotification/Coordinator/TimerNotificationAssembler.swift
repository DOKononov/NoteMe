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
    
    static func makeCreate(_ coordinator: TimerNotificationCoordinatorProtocol,
                     container: Container) -> UIViewController {
        let worker: NotificationWorker = container.resolve()
        let vm = TimerNotificationCreateVM(
            coordinator: coordinator,
            worker: worker)
        let vc = TimerNotificationVC(viewModel: vm)
        return vc
    }
    
    static func makeEdit(_ coordinator: TimerNotificationCoordinatorProtocol,
                     container: Container,
                     dto: TimerNotificationDTO) -> UIViewController {
        let worker: NotificationWorker = container.resolve()
        let vm = TimerNotificationEditVM(
            coordinator: coordinator,
            dto: dto,
            worker: worker)
        let vc = TimerNotificationVC(viewModel: vm)
        return vc
    }
}
