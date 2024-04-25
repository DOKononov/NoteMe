//
//  FirebaseBackupService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.04.24.
//

import Foundation
import FirebaseDatabaseInternal
import FirebaseAuth
import Storage

final class FirebaseBackupService {
    //TODO: setup Realtime Database rules
    
    private let backupQueue: DispatchQueue = .init(
        label: "com.noteme.backup",
        qos: .background,
        attributes: .concurrent)
    
    private var ref: DatabaseReference {
        Database.database().reference()
    }
    
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func backup(dto: any DTODescription) {
        guard let userId else { return }
        backupQueue.async { [weak ref] in
            let backupModel = BackupModel(dto: dto)
            ref?
                .child("notifications")
                .child(userId)
                .child(dto.id)
                .setValue(backupModel.buildDict())
        }
    }
    
    func loadBackup(completion: @escaping (([any DTODescription]) -> Void)) {
        guard let userId else { return }
        ref
            .child("notifications")
            .child(userId)
            .getData { [weak self] error, snapshot in
                self?.backupQueue.async {
                    guard
                        let snapshotDict = snapshot?.value as? [String: Any]
                    else {
                        completion([])
                        return
                    }
                    
                    let value = snapshotDict.map { _, value in value }
                    
                    guard
                        let data = try? JSONSerialization.data(withJSONObject: value),
                        let backupModels = try? JSONDecoder().decode(
                            [BackupModel].self,
                            from: data
                        )
                    else {
                        //log error
                        completion([])
                        return
                    }
                    completion(backupModels.map { $0.dto } )
                }
            }
    }
    
    func delete(id: String) {
        guard let userId else { return }
        backupQueue.async { [ref] in
            ref
                .child("notifications")
                .child(userId)
                .child(id)
                .removeValue()
        }
    }
}


