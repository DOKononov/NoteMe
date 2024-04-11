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
    //TODO: threads
    //TODO: setup Realtime Database rules
    
    private var ref: DatabaseReference {
        Database.database().reference()
    }
    
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func backup(dto: any DTODescription) {
        guard let userId else { return }
        let backupModel = BackupModel(dto: dto)
        ref
            .child("notifications")
            .child(userId)
            .child(dto.id)
            .setValue(backupModel.buildDict())
    }
    
    func loadBackup() {
            guard let userId else { return }
            ref
                .child("notifications")
                .child(userId)
                .getData { error, snapshot in
                    guard
                        let snapshotDict = snapshot?.value as? [String: Any]
                    else {
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
                        return
                    }
                    print(backupModels, "count: \(backupModels.count)")
                }
        }
}


