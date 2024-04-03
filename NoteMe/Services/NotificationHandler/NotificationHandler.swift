//
//  NotificationHandler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 2.04.24.
//

import Foundation
import Storage
import UserNotifications

final class NotificationHandler {
    
    private let storage: AllNotificationStorage = .init()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func checkIsCompleted() {
        notificationCenter.getDeliveredNotifications { [weak self] in
            self?.setIsCompleted(notifications: $0)
        }
    }
    
    func setIsCompleted(notification: UNNotification) {
        let id = notification.request.identifier
        let date = notification.date
        
            var dto = storage
            .fetch(predicate: .Notification.notification(by: id))
            .first 
        
        dto?.completedDate = date
        
        guard let dto else {return}
        storage.updateOrCreate(dto: dto)
    }
    
    private func setIsCompleted(notifications: [UNNotification]) {
        let ids = notifications.map { $0.request.identifier }
        let dtos = storage
            .fetch(predicate: .Notification.notifications(in: ids))
            .map { dto in
                var updatedDTO = dto
                let date = notifications
                    .first { $0.request.identifier == dto.id }?
                    .date
                updatedDTO.completedDate = date
                return updatedDTO
            }
        storage.updateDTOs(dtos: dtos)
    }
}
