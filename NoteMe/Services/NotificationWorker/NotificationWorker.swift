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
    private let baseStorage = AllNotificationStorage()
    private let locationStorage = LocationNotificationStorage()
    private let dateStorage = LocationNotificationStorage()
    private let timerStorage = LocationNotificationStorage()
    
    private let notificationService = NotificationService()
    private let imageStorage = ImageStorage()
    
    func delete(notification: any DTODescription) {
        baseStorage.delete(dto: notification)
        notificationService.deleteNotification(for: notification)
        if notification is LocationNotificationDTO {
            imageStorage.deleteImage(id: notification.id)
        }
    }
    
    
    func makeLocationNotification(dto: LocationNotificationDTO, image: UIImage) {
        locationStorage.updateOrCreate(dto: dto)
        notificationService.makeLocationNotification(
            dto: dto,
            notifyOnEntry: dto.notifyOnEntry,
            notifyOnExit: dto.notifyOnExit,
            repeats: dto.repeats)
        
        imageStorage.saveImage(id: dto.id, image: image)
    }
    
    func makeTimerNotification(dto: TimerNotificationDTO) {
        timerStorage.updateOrCreate(dto: dto)
        notificationService.makeTimerNotification(dto: dto)
    }
    
    func makeDateNotification(dto: DateNotificationDTO) {
        dateStorage.updateOrCreate(dto: dto)
        notificationService.makeDateNotification(dto: dto)
    }
    
}
