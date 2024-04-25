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
    
    init(backupService: FirebaseBackupService, 
         storage: AllNotificationStorage,
         notoficationService: NotificationServiceDataWorkerUsecase) {
        self.backupService = backupService
        self.storage = storage
        self.notoficationService = notoficationService
    }
    
    func createOrUpdate(dto: any DTODescription, completion: CompletionHandler? = nil) {
        storage.updateOrCreate(dto: dto) { [notoficationService, backupService] isSuccess in
            defer { completion?(isSuccess) }
            guard isSuccess else { return }
            notoficationService.makeNotifications(from: [dto])
            backupService.backup(dto: dto)
        }
    }
    
    func deleteByUser(dto: any DTODescription, completion: CompletionHandler? = nil) {
        storage.delete(dto: dto) { [notoficationService, backupService] isSuccess in
            defer { completion?(isSuccess) }
            guard isSuccess else { return }
            notoficationService.removeNotifications(id: [dto.id])
            backupService.delete(id: dto.id)
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
