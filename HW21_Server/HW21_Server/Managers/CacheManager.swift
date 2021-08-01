//
//  CacheManager.swift
//  HW21_Server
//
//  Created by Nata on 01.08.2021.
//

import AlamofireImage

final class CacheManager {
    
    private init() {}
    
    static let shared = CacheManager()
    
    let imageCache = AutoPurgingImageCache(
    memoryCapacity: 100_000_000,
    preferredMemoryUsageAfterPurge: 60_000_000
    )
}
