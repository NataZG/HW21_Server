//
//  CommentsVC.swift
//  HW21_Server
//
//  Created by Nata on 27.07.2021.
//

import UIKit

class CommentsVC: UITableViewController {

    var comments: [Comments] = []
    var post: Comments!

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "CommentsCell")
        let comment = comments[indexPath.row]
        cell.textLabel?.text = comment.name
        cell.detailTextLabel?.text = comment.body
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }

    func getComments(pathUrl: String) {
        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.comments = try JSONDecoder().decode([Comments].self, from: data)
                print(self.comments)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let id = comments[indexPath.row].id {
            comments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ApiService.deleteComment(idComment: id) { json, error in
                print(json as Any)
                print(error as Any)
            }
        }
    }
}
