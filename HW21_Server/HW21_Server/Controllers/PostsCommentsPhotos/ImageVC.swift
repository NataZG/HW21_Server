//
//  ImageVC.swift
//  HW21_Server
//
//  Created by Nata on 01.08.2021.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class ImageVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var photo: JSON!

    override func viewDidLoad() {
        super.viewDidLoad()
        getPhoto()
    }
    
    func getPhoto() {
        if let photoURL = photo["url"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: photoURL) {
                activityIndicator.stopAnimating()
                imageView.image = image
            } else {
                AF.request(photoURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.imageView.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: photoURL)
    }
}
            }
        }
    }
}
