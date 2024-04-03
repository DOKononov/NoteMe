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
    
    func saveImage(id: String, image: UIImage) {
        let directory = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        if
            let fileURL = directory?.appendingPathComponent(id),
            let imageData = image.pngData() {
            do {
                try imageData.write(to: fileURL)
            } catch {
                print("[IS]", "\(Self.self) failed to save image \(error)")
            }
        }
    }
    
    func loadImage(id: String) -> UIImage? {
        
        if
            let directory = manager.urls(for: .documentDirectory, in: .userDomainMask).first,
            let imageData = try? Data(contentsOf: directory.appendingPathComponent(id)){
            if let loadedImage = UIImage(data: imageData) {
                return loadedImage
            } else {
                print("[IS]", "\(Self.self) failed to convert data to image")
            }
        } else {
            print("[IS]", "\(Self.self) failed to load data")
        }
        return nil
    }
    
    func deleteImage(id: String) {
        guard
            let directory = manager
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first
        else { return }
        do {
            try manager.removeItem(at: directory.appendingPathComponent(id))
        } catch {
            print("[IS]", "\(Self.self) uneble to delete image")
        }
    }
}
