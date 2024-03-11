//
//  ImageStorage.swift
//  NoteMe
//
//  Created by Dmitry Kononov on 9.03.24.
//

import UIKit

final class ImageStorage {
    
    private var manager: FileManager {
        FileManager.default
    }
    
     func saveImage(id: String, image: UIImage?) -> String? {
        guard
            let directory = manager.urls(for: .documentDirectory,
                                         in: .userDomainMask).first
        else { return  nil }
        
        let fileURL = directory.appendingPathComponent(id)
        guard 
            let image, 
            let data = image.jpegData(compressionQuality: 1)
         else { return nil }
        
        if manager.fileExists(atPath: fileURL.path) {
            do {
                try manager.removeItem(atPath: fileURL.path)
            } catch {
                print("couldn't remove file at path", error)
            }
        }
        
        do {
            try data.write(to: fileURL)
            return fileURL.absoluteString
        } catch {
            print("error saving file with error", error)
        }
        return nil
    }
    
     func loadImage(urlString: String) -> UIImage? {
        guard
            let url = URL(string: urlString)
        else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            return image
        } catch {
            print("failed to load image",error)
            return nil
        }
    }
}
