//
//  ImageStorageWorker.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 8.05.24.
//

import UIKit

final class ImageStorageWorker {
    
    private let cloudStorage: FirebaseStorageService
    private let localStorage: ImageStorage
    
    init(cloudStorage: FirebaseStorageService, localStorage: ImageStorage) {
        self.cloudStorage = cloudStorage
        self.localStorage = localStorage
    }
    
    func upload(id: String, image: UIImage, completion: ((Bool) -> Void)?) {
        localStorage.saveImage(id: id, image: image, completion: completion)
        cloudStorage.upload(id: id, image: image, completion: nil)
    }
    
    func download(id: String, completion: @escaping ((UIImage?)-> Void)) {
        localStorage.loadImage(id: id) { [weak self] localImage in
            if let localImage {
                completion(localImage)
            } else {
                self?.cloudStorage.download(id: id) { cloudImage in
                    completion(cloudImage)
                    
                    if let cloudImage {
                        self?.localStorage.saveImage(id: id, image: cloudImage, completion: nil)
                    }
                }
            }
        }
    }
    
    func delete(id: String, completion: ((Bool) -> Void)? ) {
        localStorage.deleteImage(id: id, completion: nil)
        cloudStorage.delete(id: id, completion: nil)
    }
}
