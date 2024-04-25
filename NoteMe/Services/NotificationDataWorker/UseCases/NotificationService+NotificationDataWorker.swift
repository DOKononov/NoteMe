//
//  NotificationService+NotificationDataWorker.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 25.04.24.
//

import Foundation
import Storage

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
                print("[NotificationService+NotificationDataWorker] unknown case")
                break
            }
        }
    }
    
    func removeNotifications(id: [String]) {
        deleteNotification(for: id)
    }
}
