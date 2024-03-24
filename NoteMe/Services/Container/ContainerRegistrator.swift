//
//  ContainerRegistrator.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 16.01.24.
//

import Foundation
import Storage

final class ContainerRegistrator {
    
    static func makeContainer() -> Container {
        let container = Container()
        
        container.register { AlertService(container: container) }
        container.register { AuthService() }
        container.register { KeyboardHelper() }
        container.register { InputValidator() }
        container.register { AnimatorService() }
        container.register { DateNotificationStorage() }
        container.register { LocationNotificationStorage() }
        container.register { TimerNotificationStorage() }
        container.register { AllNotificationStorage() }
        container.register { ImageStorage() }
        container.register { NotificationService() }
        container.register { LocationNetworkService() }
        return container
    }
}
