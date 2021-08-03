//
//  AlbumsAndPhotos.swift
//  HW21_Server
//
//  Created by Nata on 31.07.2021.
//
import Alamofire
import SwiftyJSON
import UIKit

class AlbumsTableVC: UITableViewController {

    var user: User!
    var albums: [JSON] = []

    override func viewDidLoad() {
        getData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
            let photosCollectionVC = segue.destination as? PhotosCollectionVC,
            let album = sender as? JSON {
            photosCollectionVC.user = user
            photosCollectionVC.album = album
        }
    }
    private func getData() {

        guard let userId = user.id else { return }
        guard let url = URL(string: "\(ApiConstants.albumsPath)?userId=\(userId)") else { return }

        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                self.albums = JSON(data).arrayValue
                self.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = albums[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: album)
    }
}
