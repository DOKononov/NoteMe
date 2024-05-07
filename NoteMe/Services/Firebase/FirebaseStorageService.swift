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
    
    var errorDescription: String? {
        return self.rawValue
    }
}

final class FirebaseStorageService {
    
    private enum Path {
        static let location = "locationNotifications"
    }
    
    typealias UploadImageModel = (id: String, image: UIImage)
    typealias UploadCompletion = (Bool, URL?) -> Void
    typealias DownloadImageCompletion = (Bool, UIImage?) -> Void
    
    private let queue = DispatchQueue(label: "com.noteme.firebase.storage",
                                      qos: .utility,
                                      attributes: .concurrent)
    
    private var storage: StorageReference {
        Storage.storage().reference()
    }
    
    private var clientId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func upload(model: UploadImageModel, completion: UploadCompletion?) {
        guard let clientId else {
            FirebaseStorageError.clientIdIsNil.log()
            completion?(false, nil)
            return
        }
        
        queue.async { [weak self] in
            guard let data = model.image.pngData() else {
                FirebaseStorageError.imageToDataFailed.log()
                completion?(false, nil)
                return
            }
            
            let ref = self?.storage.child("\(Path.location)/\(clientId)/\(model.id).png")
            ref?.putData(data) { metaData, error in
                guard error == nil  else {
                    error?.log()
                    completion?(false, nil)
                    return
                }
                
                ref?.downloadURL { fileURL, error in
                    guard error == nil  else {
                        error?.log()
                        completion?(false, nil)
                        return
                    }
                    completion?(true, fileURL)
                }
            }
        }
    }
    
    func download(fileName: String, completion: DownloadImageCompletion? ) {
        guard let clientId else {
            FirebaseStorageError.clientIdIsNil.log()
            completion?(false, nil)
            return
        }
        let ref = storage.child("\(Path.location)/\(clientId)/\(fileName).png")
        //max file size 10mb
        ref.getData(maxSize: 10 * 1024 * 1024) { [weak queue] data, error in
            queue?.async {
                if error != nil {
                    error?.log()
                    completion?(false, nil)
                } else if let data {
                    guard let image = UIImage(data: data) else {
                        FirebaseStorageError.dataToImageFailed.log()
                        completion?(false, nil)
                        return
                    }
                    completion?(true, image)
                } else {
                    FirebaseStorageError.dataIsNil.log()
                    completion?(false, nil)
                }
            }
        }
    }
    
    
}
