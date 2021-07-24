//
//  ImageViewController.swift
//  HW21_Server
//
//  Created by Nata on 24.07.2021.
//

import UIKit

class ImageViewController: UIViewController {
    // MARK: Internal

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true // будет скрываться после остановки
    }

    // MARK: Private

    private let imageUrl = "https://images.pexels.com/photos/2327372/pexels-photo-2327372.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"

    private func fetchImage() {
        guard let url = URL(string: imageUrl) else { return }

//        let session = URLSession.shared // синглтон

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response {
                print(response)
            }
           
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
