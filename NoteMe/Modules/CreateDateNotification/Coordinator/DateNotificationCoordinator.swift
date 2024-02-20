//
//  DateNotificationCoordinator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.02.24.
//

import UIKit
import Storage

final class DateNotificationCoordinator: Coordinator {
    private var rootVC: UIViewController?
    private let container: Container
    private let dto: DateNotificationDTO?
    
    init(container: Container,
         dto: DateNotificationDTO? = nil) {
        self.container = container
        self.dto = dto
    }

    override func start() -> UIViewController {
        let vc = DateNotificationAssembler.make(self,
                                                container: container,
                                                dto: dto)
        rootVC = vc
        return vc
    }
}

extension DateNotificationCoordinator: DateNotificationCoordinatorProtocol {
    
}
