//
//  CachedImageView.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//
// Modeled from this article on medium
// https://medium.com/swift2go/the-nifty-self-caching-imageview-with-nscache-e84b12a82b8b

import UIKit

class CachedImageView: UIImageView {
    
    private var imageEndPoint: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentMode = .scaleAspectFit
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
    
    func loadImage(with path: String) {
        self.imageEndPoint = path
        
        if let imageFromCache = UIImage.imageCache.object(forKey: path as AnyObject) as? UIImage {
            setImage(imageFromCache)
            return
        }
        
        UIImage.cacheImage(from: path) { [weak self] image in
            guard let imageFromCache = image else {
                return
            }
            
            self?.setImage(imageFromCache)
        }
    }
}
