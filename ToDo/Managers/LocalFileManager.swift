//
//  LocalFileManager.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//

import Foundation
import UIKit

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init (){}
    
    static let folderName = "localStorage"
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathExtension(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String)  -> URL? {
        guard let folderUrl = getURLForFolder(folderName: folderName) else {
            return nil
        }
        
        return folderUrl.appendingPathExtension(imageName + ".png")
    }
    
    private func createFolderIfNeeded(folderName: String){
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory: \(folderName) . \(error)")
            }
        }
    }
    
    func saveImage(image: UIImage, imageName: String, folderName: String){
        
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
            else { return }

        do {
            try data.write(to: url)
        } catch (let error){
            print("Error saving image: \(imageName). \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
}
