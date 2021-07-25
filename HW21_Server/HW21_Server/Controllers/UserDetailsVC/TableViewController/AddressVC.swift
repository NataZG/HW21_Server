//
//  UserDetailsVC.swift
//  HW21_Server
//
//  Created by Nata on 25.07.2021.
//

import UIKit

class AddressVC: UITableViewController {

    private let jsonUrl = "https://jsonplaceholder.typicode.com/users"

    var index: Int?
    var userAddress: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       fetchData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userAddress.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        let user = userAddress[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    // MARK: - Map test

    /*:func passData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mapVC = storyboard.instantiateViewController(identifier: "goToMap") as? MapVC else { return }
        
        show(mapVC, sender: nil)
    }*/

    func fetchData() {
        guard let url = URL(string: jsonUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.userAddress = try JSONDecoder().decode([User].self, from: data)
                print(self.userAddress)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
