//
//  UsersVC.swift
//  HW21_Server
//
//  Created by Nata on 24.07.2021.
//

import UIKit

class UsersVC: UITableViewController {
    
    // MARK: Private

    private let jsonUrl = "https://jsonplaceholder.typicode.com/users"

    private var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // fetchData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }

    func fetchData() {
        guard let url = URL(string: jsonUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.users = try JSONDecoder().decode([User].self, from: data)
                print(self.users)
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
