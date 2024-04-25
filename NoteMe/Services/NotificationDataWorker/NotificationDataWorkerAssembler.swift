//
//  NotificationDataWorkerAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.04.24.
//

import Foundation
import Storage

final class NotificationDataWorkerAssembler {
    private init() {}
    
    static func make(container: Container) -> NotificationDataWorker {
        let backupService: FirebaseBackupService = container.resolve()
        let storage: AllNotificationStorage = container.resolve()
        let notoficationService: NotificationService = container.resolve()
        
        
        let worker = NotificationDataWorker(backupService: backupService,
                                            storage: storage,
                                            notoficationService: notoficationService)
        return worker
    }
}
