//
//  NotificationWorker.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 3.04.24.
//

import UIKit
import Storage
import CoreLocation

protocol WorkerImageStorageUsecase {
    func deleteImage(id: String)
    func saveImage(id: String, image: UIImage)
}

protocol WorkerFirebaseBackupServiceUsecase {
    func backup(dto: any DTODescription)
}

protocol WorkerNotificationServiceUseCase {
    func deleteNotification(for dto: any DTODescription)
    func makeTimerNotification(dto: TimerNotificationDTO)
    func makeDateNotification(dto: DateNotificationDTO)
    func makeLocationNotification(
        dto: LocationNotificationDTO,
        notifyOnEntry: Bool,
        notifyOnExit: Bool,
        repeats: Bool)
}

protocol WorkerAllNotificationStorageUsecase {
    func delete(dto: any DTODescription, completion: ((Bool) -> Void)?)
}

protocol WorkerLocationStorageUsecase {
    func updateOrCreate(dto: any DTODescription, completion: ((Bool) -> Void)?)
}

protocol WorkerDateStorageUsecase {
    func updateOrCreate(dto: any DTODescription, completion: ((Bool) -> Void)?)
}

protocol WorkerTimerStorageUsecase {
    func updateOrCreate(dto: any DTODescription, completion: ((Bool) -> Void)?)
}

final class NotificationWorker {
    private let baseStorage: WorkerAllNotificationStorageUsecase
    private let locationStorage: WorkerLocationStorageUsecase
    private let dateStorage: WorkerDateStorageUsecase
    private let timerStorage: WorkerTimerStorageUsecase
    private let notificationService: WorkerNotificationServiceUseCase
    private let imageStorage: WorkerImageStorageUsecase
    private let database: WorkerFirebaseBackupServiceUsecase
    
    init(database: WorkerFirebaseBackupServiceUsecase,
         imageStorage: WorkerImageStorageUsecase,
         notificationService: WorkerNotificationServiceUseCase,
         baseStorage: WorkerAllNotificationStorageUsecase,
         locationStorage: WorkerLocationStorageUsecase,
         dateStorage: WorkerDateStorageUsecase,
         timerStorage: WorkerTimerStorageUsecase
    ) {
        self.imageStorage = imageStorage
        self.database = database
        self.notificationService = notificationService
        self.baseStorage = baseStorage
        self.locationStorage = locationStorage
        self.dateStorage = dateStorage
        self.timerStorage = timerStorage
    }
    
    func delete(notification: any DTODescription) {
        baseStorage.delete(dto: notification, completion: nil)
        notificationService.deleteNotification(for: notification)
        if notification is LocationNotificationDTO {
            imageStorage.deleteImage(id: notification.id)
        }
    }
    
    
    func makeLocationNotification(dto: LocationNotificationDTO, image: UIImage) {
        locationStorage.updateOrCreate(dto: dto, completion: nil)
        notificationService.makeLocationNotification(
            dto: dto,
            notifyOnEntry: dto.notifyOnEntry,
            notifyOnExit: dto.notifyOnExit,
            repeats: dto.repeats)
        imageStorage.saveImage(id: dto.id, image: image)
        database.backup(dto: dto)
    }
    
    func makeTimerNotification(dto: TimerNotificationDTO) {
        timerStorage.updateOrCreate(dto: dto, completion: nil)
        notificationService.makeTimerNotification(dto: dto)
        database.backup(dto: dto)
    }
    
    func makeDateNotification(dto: DateNotificationDTO) {
        dateStorage.updateOrCreate(dto: dto, completion: nil)
        notificationService.makeDateNotification(dto: dto)
        database.backup(dto: dto)
    }
    
}
