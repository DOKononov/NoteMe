//
//  TimerNotificationAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

final class TimerNotificationAssembler {
    private init() {}
    
    static func make(_ coordinator: TimerNotificationCoordinatorProtocol) -> UIViewController {
        let vm = TimerNotificationVM(coordinator: coordinator)
        let vc = TimerNotificationVC(viewModel: vm)
        return vc
    }
}
