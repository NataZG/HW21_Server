//
//  PostsVC.swift
//  HW21_Server
//
//  Created by Nata on 27.07.2021.
//

import UIKit

class PostsVC: UITableViewController {

    var posts: [Posts] = []
    var user: User!
    //private let jsonUrl = "https://jsonplaceholder.typicode.com/posts"

    override func viewWillAppear(_ animated: Bool) {
        getPosts()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showComments",
            let postId = sender as? Int,
            let commentsVC = segue.destination as? CommentsVC {
            commentsVC.getComments(pathUrl: "\(ApiConstants.postsPath)/\(postId)/comments")
        } /*else if segue.identifier == "addPosts",
                  let addPostVC = segue.destination as? AddPostVC {
            addPostVC.user = user
         }*/
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let postId = posts[indexPath.row].id
        performSegue(withIdentifier: "showComments", sender: postId)
    }

    private func getPosts() {
      guard let userId = user.id else { return }
      let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"

       guard let url = URL(string: pathUrl) else { return }
        //guard let url = URL(string: jsonUrl) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.posts = try JSONDecoder().decode([Posts].self, from: data)
                print(self.posts)
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

   
