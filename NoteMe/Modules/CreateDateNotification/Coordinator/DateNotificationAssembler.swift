//
//  DateNotificationAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit

final class DateNotificationAssembler {
    private init() {}
    
    static func make(_ coordinator: DateNotificationCoordinatorProtocol) -> UIViewController {
        let viewModel = DateNotificationVM(coordinator: coordinator)
        let vc = DateNotificationVC(viewModel: viewModel)
        return vc
    }
}
