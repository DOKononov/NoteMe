//
//  ImageStorageWorkerAssembler.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.05.24.
//

import Foundation

final class ImageStorageWorkerAssembler {
    private init() {}
    
    static func make(container: Container) -> ImageStorageWorker {
        
        let cloudStorage: FirebaseStorageService = container.resolve()
        let localStorage: ImageStorage = container.resolve()
        
        let worker = ImageStorageWorker(cloudStorage: cloudStorage,
                                        localStorage: localStorage)
        return worker
    }
}
