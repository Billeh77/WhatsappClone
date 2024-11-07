//
//  ImageUploader.swift
//  Whatsapp
//
//  Created by Emile Billeh on 27/05/2024.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { metadata , error in
            if let error = error {
                print( "DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    print("DEBUG: Failed to retrieve download URL with error: \(error.localizedDescription)")
                    return
                }
                
                guard let urlString = url?.absoluteString else { return }
                completion(urlString)
            }
            
        }
    }
}
