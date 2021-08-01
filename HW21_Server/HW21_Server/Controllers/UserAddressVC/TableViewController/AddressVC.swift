//
//  UserDetailsVC.swift
//  HW21_Server
//
//  Created by Nata on 25.07.2021.
//

import UIKit

class AddressVC: UITableViewController {

    private let jsonUrl = "https://jsonplaceholder.typicode.com/users"

    static var coordinates: [Address] = []

    var index: Int!
    var userAddress: User {
        UsersVC.users[index]
    }
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        let user = userAddress
        cell.configure(with: user)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPosts",
           let PostsVC = segue.destination as? PostsVC {
            PostsVC.user = userAddress
    }
       if segue.identifier == "showAlbums",
           let AlbumsVC = segue.destination as? AlbumsTableVC {
        AlbumsVC.user = userAddress
         }
    }


    // MARK: - Map test

    /*:func passData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mapVC = storyboard.instantiateViewController(identifier: "goToMap") as? MapVC else { return }
        
        show(mapVC, sender: nil)
    }*/

}
 
