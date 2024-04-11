//
//  NotificationWorkerAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 11.04.24.
//

import Foundation
import Storage

final class NotificationWorkerAssembler {
    private init() {}
    
    static func make(container: Container) -> NotificationWorker {
        
        let database: FirebaseBackupService = container.resolve()
        let imageStorage: ImageStorage = container.resolve()
        let notificationService: NotificationService = container.resolve()
        let baseStorage: AllNotificationStorage = container.resolve()
        let locationStorage: LocationNotificationStorage = container.resolve()
        let dateStorage: DateNotificationStorage = container.resolve()
        let timerStorage: TimerNotificationStorage = container.resolve()
        
        return NotificationWorker(
            database: database,
            imageStorage: imageStorage,
            notificationService: notificationService,
            baseStorage: baseStorage,
            locationStorage: locationStorage,
            dateStorage: dateStorage,
            timerStorage: timerStorage
        )
    }
}
