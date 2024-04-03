//
//  NotificationWorker.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 3.04.24.
//

import UIKit
import Storage
import CoreLocation

final class NotificationWorker {
    private let storage = AllNotificationStorage()
    private let notificationService = NotificationService()
    private let imageStorage = ImageStorage()
    
    func delete(notification: any DTODescription) {
        storage.delete(dto: notification)
        notificationService.deleteNotification(for: notification)
        if notification is LocationNotificationDTO {
            imageStorage.deleteImage(id: notification.id)
        }
    }
    
    
    func makeLocationNotification(dto: LocationNotificationDTO,
                                  image: UIImage,
                                  notifyOnEntry: Bool = true,
                                  notifyOnExit: Bool = false,
                                  repeats: Bool = false
    ) {
        storage.updateOrCreate(dto: dto)
        notificationService.makeLocationNotification(
            dto: dto,
            notifyOnEntry: notifyOnEntry,
            notifyOnExit: notifyOnExit,
            repeats: repeats)
        
        imageStorage.saveImage(id: dto.id, image: image)
    }
    
    func makeTimerNotification(dto: TimerNotificationDTO) {
        storage.updateOrCreate(dto: dto)
        notificationService.makeTimerNotification(dto: dto)
    }
    
    func makeDateNotification(dto: DateNotificationDTO) {
        storage.updateOrCreate(dto: dto)
        notificationService.makeDateNotification(dto: dto)
    }
    
}
