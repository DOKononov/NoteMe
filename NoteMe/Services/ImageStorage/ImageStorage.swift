//
//  ImageStorage.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.03.24.
//

import UIKit

enum ImageStorageError: String, LocalizedError {
    case dataLoadingFailed = "Failed to load data"
    case dataToImageFailed = "Data can not be used as image"
    case imageToDataError = "Failed to convert image to data"
    case deleteImageError = "Uneble to delete image"
    case fileURLPathError = "failed to make file path URL"
    
    var errorDescription: String? { self.rawValue }
}

final class ImageStorage {
    
    private var manager: FileManager { FileManager.default }
    private var directory: URL? {
        manager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    private let queue = DispatchQueue(label: "com.noteme.localStorage",
                                      qos: .utility,
                                      attributes: .concurrent)
    
    func saveImage(id: String, image: UIImage,
                   completion: ((Bool) -> Void)?) {
        guard let fileURL = directory?.appendingPathComponent(id) else {
            ImageStorageError.fileURLPathError.log()
            completion?(false)
            return
        }
        queue.async {
            guard let imageData = image.pngData() else {
                ImageStorageError.imageToDataError.log()
                completion?(false)
                return
            }
            
            do {
                try imageData.write(to: fileURL)
                completion?(true)
            } catch {
                error.log()
                completion?(false)
            }
        }
    }
    
    func loadImage(id: String, completion: @escaping ((UIImage?)-> Void)) {
        queue.async { [weak self] in
            guard
                let directory = self?.directory,
                let imageData = try? Data(contentsOf: directory.appendingPathComponent(id))
            else {
                ImageStorageError.dataLoadingFailed.log()
                completion(nil)
                return
            }
            
            guard
                let image = UIImage(data: imageData)
            else {
                ImageStorageError.dataToImageFailed.log()
                completion(nil)
                return
            }
            completion(image)
        }
    }
    
    
    func deleteImage(id: String, completion: ((Bool) -> Void)?) {
        guard
            let directory
        else {
            ImageStorageError.fileURLPathError.log()
            completion?(false)
            return
        }
        
        do {
            try manager.removeItem(at: directory.appendingPathComponent(id))
            completion?(true)
        } catch {
            ImageStorageError.deleteImageError.log()
            completion?(false)
        }
    }  
    
    func deleteAll(completion: ((Bool) -> Void)?) {
        guard let directory else {
            ImageStorageError.fileURLPathError.log()
            completion?(false)
            return
        }
        
        do {
            let urls = try manager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            try urls.forEach { [weak self] url in
                try self?.manager.removeItem(at: url)
            }
            completion?(true)
        } catch {
            ImageStorageError.deleteImageError.log()
            completion?(false)
        }
    }
}
