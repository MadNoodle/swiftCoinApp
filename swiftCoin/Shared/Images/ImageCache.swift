//
//  ImageCache.swift
//  swiftCoin
//
//  Created by User on 5.1.2024.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString,UIImage>()
    
    private init() {}
    
    func set(_ value: UIImage, forKey key: String) {
        cache.setObject(value, forKey: key as NSString)
    }
    
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
