//
//  CompanyVC.swift
//  HW21_Server
//
//  Created by Nata on 25.07.2021.
//

import UIKit

class CompanyVC: UITableViewController {

    private let jsonUrl = "https://jsonplaceholder.typicode.com/users"

    var userCompany: [User] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userCompany.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        let user = userCompany[indexPath.row]
        cell.configure(with: user)
        return cell
    }

    func fetchData() {
        guard let url = URL(string: jsonUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.userCompany = try JSONDecoder().decode([User].self, from: data)
                print(self.userCompany)
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
