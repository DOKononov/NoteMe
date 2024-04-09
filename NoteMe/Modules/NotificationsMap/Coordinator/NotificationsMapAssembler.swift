//
//  NotificationsMapAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 18.03.24.
//

import UIKit
import Storage

final class NotificationsMapAssembler {
    private init() {}
    
    static func make(_ coordinator: NotificationsMapCoordinatorProtocol) -> UIViewController {
        let vm = NotificationsMapVM(coordinator: coordinator,
                                    frc: makeFRC())
        let vc = NotificationsMapVC(viewmodel: vm)
        return vc
    }
    
    private static func makeFRC() -> FRCService<BaseNotificationDTO> {
        .init { request in
            request.predicate = .Notification.allNotComplited
            request.sortDescriptors = [.Notification.byDate]
        }
    }
}
