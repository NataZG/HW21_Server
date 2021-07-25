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
  
    static var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UsersVC.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserCell
        let user = UsersVC.users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* guard segue.identifier == "goToAddress" else { return }
       guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let address = UsersVC.users[indexPath.row]
        let addressVC = segue.destination as! AddressVC*/
        guard segue.identifier == "goToAddress" else { return }
                guard let indexPath = tableView.indexPathForSelectedRow else { return }

                let AddressVC = segue.destination as! AddressVC
        AddressVC.index = indexPath.row

        
        guard segue.identifier == "goToCompany" else { return }
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                let CompanyVC = segue.destination as! CompanyVC
        CompanyVC.index = indexPath.row
        CompanyVC.modalPresentationStyle = .fullScreen
        CompanyVC.modalTransitionStyle = .coverVertical
        present(CompanyVC, animated: true, completion: nil)

    }


    func fetchData() {
        guard let url = URL(string: jsonUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                UsersVC.users = try JSONDecoder().decode([User].self, from: data)
                print(UsersVC.users)
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
