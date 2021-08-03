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

    private let imageUrl = "https://images.unsplash.com/photo-1609428275645-7ab5027d4f7b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHRhYmxlJTIwbW91bnRhaW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"

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
