//
//  PhotoCollectionVC.swift
//  HW21_Server
//
//  Created by Nata on 01.08.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class PhotoCollectionVC: UICollectionViewCell {
    
    var photo: JSON!
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configureCell() {
        photoImage.image = #imageLiteral(resourceName: "photo_2021-08-01 10.22.30")
    }
    
    func getThumbnail() {
        if let thumbnailURL = photo["thumbnailURL"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
                activityIndicator.stopAnimating()
                photoImage.image = image
            } else {
                AF.request(thumbnailURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.photoImage.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                    }
                }
            }
        }
    }
    
}
