//
//  WebImageManager.swift
//  YapeFood
//
//  Created by Marcelo Stefano Velasquez Herrera on 6/03/23.
//

import Foundation
import SDWebImage

class WebImageManager {
    
    static func downloadImage(nameImg: String, completion: @escaping (UIImage) -> Void) {
        SDWebImageManager.shared.loadImage(with: URL(string: nameImg), options: .continueInBackground, progress: nil) { image, data, error, cacheType, isFinished, url in
            if error == nil {
                guard let imageDownloaded = image else { return }
                completion(imageDownloaded)
            } else {
                // Error al descargar la imagen
                completion(UIImage())
            }
        }
    }
    
}
