//
//  CasheManager.swift
//  DeliveryApp
//
//  Created by Abduraxmon on 04/04/23.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()

    static func setImageCache(_ url: String, _ data: Data?) {
        
    }
    static func getImageCache(_ url: String) -> Data? {
        cache[url]
    }
    
}
