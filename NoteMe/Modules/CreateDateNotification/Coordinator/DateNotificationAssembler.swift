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
    
    static func make(_ coordinator: DateNotificationCoordinatorProtocol,
                     container: Container) -> UIViewController {
        let storage: DateNotificationStorage = container.resolve()
        let viewModel = DateNotificationVM(coordinator: coordinator, storage: storage)
        let vc = DateNotificationVC(viewModel: viewModel)
        return vc
    }
}
