//
//  ImageCacheManager.swift
//  CachingDemo
//
//  Created by BJIT on 20/11/23.
//

import Foundation
import UIKit

class CacheManager {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let dataCache = NSCache<NSString, NSData>()
    
    init() {
//        imageCache.totalCostLimit = 50 * 1024 * 1024
//        imageCache.countLimit = 6
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    func setImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    func removeAllImages() {
        imageCache.removeAllObjects()
    }
    
    
    
    func getData(forKey key: String) -> Data? {
        return dataCache.object(forKey: key as NSString) as Data?
    }
    func setData(_ data: Data, forKey key: String) {
        dataCache.setObject(data as NSData, forKey: key as NSString)
    }
    func removeAllData() {
        dataCache.removeAllObjects()
    }
}
