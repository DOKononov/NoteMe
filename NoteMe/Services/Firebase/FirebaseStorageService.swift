//
//  FirebaseStorageService.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 7.05.24.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

enum FirebaseStorageError: String, LocalizedError {
    case clientIdIsNil = "Firebase client id is nil"
    case imageToDataFailed = "Image can not be parsed to png data"
    case dataToImageFailed = "Data can not be used as image"
    case dataIsNil = "Download data successed, BUT data is nil"
    
    var errorDescription: String? { self.rawValue }
}

final class FirebaseStorageService {
    
    private enum Path {
        static let location = "locationNotifications"
    }
    
    private let queue = DispatchQueue(label: "com.noteme.firebase.storage",
                                      qos: .utility,
                                      attributes: .concurrent)
    
    private var storage: StorageReference {
        Storage.storage().reference()
    }
    
    private var clientId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func upload(id: String, image: UIImage, completion: ((Bool) -> Void)?) {
        guard let clientId else {
            FirebaseStorageError.clientIdIsNil.log()
            completion?(false)
            return
        }
        
        queue.async { [weak self] in
            guard let data = image.pngData() else {
                FirebaseStorageError.imageToDataFailed.log()
                completion?(false)
                return
            }
            
            let ref = self?.storage.child("\(Path.location)/\(clientId)/\(id).png")
            ref?.putData(data) { metaData, error in
                guard error == nil  else {
                    error?.log()
                    completion?(false)
                    return
                }
                completion?(true)
            }
        }
    }
    
    func download(id: String, completion: ((UIImage?) -> Void)? ) {
        guard let clientId else {
            FirebaseStorageError.clientIdIsNil.log()
            completion?(nil)
            return
        }
        let ref = storage.child("\(Path.location)/\(clientId)/\(id).png")
        //max file size 1mb
        ref.getData(maxSize: 1 * 1024 * 1024) { [weak queue] data, error in
            queue?.async {
                if error != nil {
                    error?.log()
                    completion?(nil)
                } else if let data {
                    guard let image = UIImage(data: data) else {
                        FirebaseStorageError.dataToImageFailed.log()
                        completion?(nil)
                        return
                    }
                    completion?(image)
                } else {
                    FirebaseStorageError.dataIsNil.log()
                    completion?(nil)
                }
            }
        }
    }
    
    
    func delete(id: String, completion: ((Bool) -> Void)?) {
        guard let clientId else {
            FirebaseStorageError.clientIdIsNil.log()
            completion?(false)
            return
        }
        let ref = storage.child("\(Path.location)/\(clientId)/\(id).png")
        ref.delete { [weak self] error in
            self?.queue.async {
                if let error {
                    error.log()
                    completion?(false)
                    return
                } else {
                    completion?(true)
                    return
                }
            }
         
        }

    }
}
