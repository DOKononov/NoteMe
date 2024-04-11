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
         dto: DateNotificationDTO?) {
        self.container = container
        self.dto = dto
    }
    
    override func start() -> UIViewController {
        
        if let dto {
            let vc = DateNotificationAssembler.makeEdit(
                self,
                container: container,
                dto: dto
            )
            rootVC = vc
            return vc
        } else {
            let vc = DateNotificationAssembler.makeCreate(
                self,
                container: container
            )
            rootVC = vc
            return vc
        }  
    }
}

extension DateNotificationCoordinator: DateNotificationCoordinatorProtocol {}
