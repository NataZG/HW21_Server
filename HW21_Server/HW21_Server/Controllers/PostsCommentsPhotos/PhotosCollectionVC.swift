//
//  PhotosCollectionVC.swift
//  HW21_Server
//
//  Created by Nata on 01.08.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

private let reuseIdentifier = "Cell"

class PhotosCollectionVC: UICollectionViewController {

    var user: User!
    var album: JSON!
    var photos: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album["title"].string
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imageVC = segue.destination as? ImageVC,
            let photo = sender as? JSON {
            imageVC.photo = photo
        }
    }

    func getData() {
        if let album = album,
            let albumId = album["id"].int,
            let url = URL(string: "\(ApiConstants.photosPath)?albumId=\(albumId)") {

            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(let data):
                    self.photos = JSON(data).arrayValue
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }


    // MARK: UICollectionViewDataSource

    /* override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionVC
        cell.photo = photos[indexPath.row]
        cell.configureCell()
        cell.getThumbnail()
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPhoto", sender: photos[indexPath.row])
    }
}
