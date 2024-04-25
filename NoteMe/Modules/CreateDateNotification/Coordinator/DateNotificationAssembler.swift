//
//  DateNotificationAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import Storage

final class DateNotificationAssembler {
    private init() {}
    
    static func makeCreate(_ coordinator: DateNotificationCoordinatorProtocol,
                           container: Container) -> UIViewController {
        let worker: NotificationDataWorker = container.resolve()
        let viewModel = DateNotificationCreateVM(
            coordinator: coordinator,
            worker: worker
        )
        let vc = DateNotificationVC(viewModel: viewModel)
        return vc
    }
    
    static func makeEdit(_ coordinator: DateNotificationCoordinatorProtocol,
                         container: Container,
                         dto: DateNotificationDTO) -> UIViewController {
        let worker: NotificationDataWorker = container.resolve()
        let viewModel = DateNotificationEditVM(
            coordinator: coordinator,
            worker: worker,
            dto: dto
        )
        let vc = DateNotificationVC(viewModel: viewModel)
        return vc
    }
}
