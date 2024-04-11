//
//  FirebaseBacupService+NotificationWorker.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 11.04.24.
//

import Foundation
import Storage

extension FirebaseBackupService: WorkerFirebaseBackupServiceUsecase {}
extension ImageStorage: WorkerImageStorageUsecase {}
extension NotificationService: WorkerNotificationServiceUseCase {}
extension AllNotificationStorage: WorkerAllNotificationStorageUsecase {}
extension LocationNotificationStorage: WorkerLocationStorageUsecase {}
extension DateNotificationStorage: WorkerDateStorageUsecase {}
extension TimerNotificationStorage: WorkerTimerStorageUsecase {}
