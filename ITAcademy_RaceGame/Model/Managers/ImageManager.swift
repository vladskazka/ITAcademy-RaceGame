//
//  ImageManager.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 22.05.2024.
//

import UIKit

final class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func saveImage(_ image: UIImage) -> String? {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }

        let fileName = UUID().uuidString
        let fileURL = directory.appendingPathComponent(fileName)
        print(fileURL)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try? FileManager.default.removeItem(atPath: fileURL.path)
        }
        
        let size = CGSize(width: 250, height: 250)
        guard let data = image.preparingThumbnail(of: size)?.jpegData(compressionQuality: 1.0) else { return nil }
        
        try? data.write(to: fileURL)
        
        return fileName
    }
    
    func loadImage(_ imageName: String) -> UIImage? {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = directory.appendingPathComponent(imageName)
        let image = UIImage(contentsOfFile: fileURL.path)
        
        return image
    }
}


