//
//  NotificationDataWorker.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 23.04.24.
//

import Foundation
import Storage
import CoreData

protocol NotificationServiceDataWorkerUsecase {
    func makeNotifications(from dtos: [any DTODescription])
    func removeNotifications(id: [String])
}

final class NotificationDataWorker {
    typealias CompletionHandler = (Bool) -> Void
    
    private let backupService: FirebaseBackupService
    private let storage: AllNotificationStorage
    private let notoficationService: NotificationServiceDataWorkerUsecase
    private let imageWorker: ImageStorageWorker
    
    init(backupService: FirebaseBackupService, 
         storage: AllNotificationStorage,
         notoficationService: NotificationServiceDataWorkerUsecase,
         imageWorker: ImageStorageWorker) {
        self.backupService = backupService
        self.storage = storage
        self.notoficationService = notoficationService
        self.imageWorker = imageWorker
    }
    
    func createOrUpdate(dto: any DTODescription, completion: CompletionHandler? = nil) {
        storage.updateOrCreate(dto: dto) { [weak self] isSuccess in
            defer { completion?(isSuccess) }
            guard isSuccess else { return }
            self?.notoficationService.makeNotifications(from: [dto])
            self?.backupService.backup(dto: dto)
        }
    }
    
    func deleteByUser(dto: any DTODescription, completion: CompletionHandler? = nil) {
        storage.delete(dto: dto) { [weak self] isSuccess in
            defer { completion?(isSuccess) }
            guard isSuccess else { return }
            self?.notoficationService.removeNotifications(id: [dto.id])
            self?.backupService.delete(id: dto.id)
            self?.imageWorker.delete(id: dto.id, completion: nil)
        }
    }
    
    func deleteAllByLogout(completion: CompletionHandler? = nil) {
        let allDTOs = storage.fetch()
        let allIds = allDTOs.map { $0.id }
        notoficationService.removeNotifications(id: allIds)
        storage.deleteAll(dtos: allDTOs, completion: completion)
    }
    
    func restore(completion: CompletionHandler? = nil) {
        backupService.loadBackup { [weak self] dtos in
            self?.storage.createDTOs(dtos: dtos) { isSuccess in
                defer { completion?(isSuccess) }
                guard isSuccess else { return }
                self?.notoficationService.makeNotifications(from: dtos)
            }
        }
    }
}
