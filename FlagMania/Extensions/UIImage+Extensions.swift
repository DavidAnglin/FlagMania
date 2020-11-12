//
//  UIImage+Extensions.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import UIKit

extension UIImage {
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func cacheImage(from endpoint: String, completion: @escaping (UIImage?) -> ()) {
        
        ImageService(apiClient: APIClient()).fetchImage(for: endpoint) { result in
            
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: endpoint as AnyObject)
                }
                
                completion(image)
            case .failure:
                completion(nil)
            }
        }
    }
}
