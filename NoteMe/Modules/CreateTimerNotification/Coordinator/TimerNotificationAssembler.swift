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
                     container: Container) -> UIViewController {
        let storage: TimerNotificationStorage = container.resolve()
        let vm = TimerNotificationVM(coordinator: coordinator, storage: storage)
        let vc = TimerNotificationVC(viewModel: vm)
        return vc
    }
}
