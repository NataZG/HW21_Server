//
//  CompanyVC.swift
//  HW21_Server
//
//  Created by Nata on 25.07.2021.
//

import UIKit

class CompanyVC: UITableViewController {

    private let jsonUrl = "https://jsonplaceholder.typicode.com/users"

    //var userCompany: [User] = []
    var index: Int!
    var company: User {
        UsersVC.users[0]
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        let user = company
        cell.configure(with: user)
        return cell
    }

}
