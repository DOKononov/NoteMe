//
//  NotificationsMapAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 18.03.24.
//

import UIKit

final class NotificationsMapAssembler {
    private init() {}
    
    static func make(_ coordinator: NotificationsMapCoordinatorProtocol) -> UIViewController {
        let vm = NotificationsMapVM(coordinator: coordinator)
        let vc = NotificationsMapVC(viewmodel: vm)
        return vc
    }
}
