//
//  NotificationService+NotificationDataWorker.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.04.24.
//

import Foundation
import Storage

enum NotificationServiceError: String, LocalizedError {
    case unknownDTOType = "Unknown DTO type"
    
    var errorDescription: String? { self.rawValue }
}

extension NotificationService: NotificationServiceDataWorkerUsecase {
    func makeNotifications(from dtos: [any DTODescription]) {
        dtos.forEach { dto in
            switch dto {
            case is DateNotificationDTO:
                makeDateNotification(dto: dto as! DateNotificationDTO)
            case is TimerNotificationDTO:
                makeTimerNotification(dto: dto as! TimerNotificationDTO)
            case is LocationNotificationDTO:
                makeLocationNotification(dto: dto as! LocationNotificationDTO)
            default:
                NotificationServiceError.unknownDTOType.log()
                break
            }
        }
    }
    
    func removeNotifications(id: [String]) {
        deleteNotification(for: id)
    }
}
