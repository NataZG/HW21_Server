//
//  AddPostVC.swift
//  HW21_Server
//
//  Created by Nata on 31.07.2021.
//
import Alamofire
import SwiftyJSON
import UIKit

class AddPostVC: UIViewController {

    @IBOutlet weak var titlePostTF: UITextField!
    @IBOutlet weak var textPostTF: UITextView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func addPostAction(_ sender: Any) {
        if let userId = user.id,
           let title = titlePostTF.text,
           let text = textPostTF.text,
           let url = ApiConstants.postPathURL {
            
            // Set Up request
            var request = URLRequest(url: url)
            
            // HEADER
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // BODY
            let post: [String: Any] = ["userId": userId,
                                       "title": title,
                                       "body": text]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: post, options: []) else {return}
            request.httpBody = httpBody
            
            // Create and post new request
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in print(response ?? "")
                if let data = data {
                    print(JSON(data))
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                } else if let error = error {
                    print(error)
                }
            }.resume()
        }
    }
    
   @IBAction func addAFPostAction(_ sender: Any) {
        if let userId = user.id,
           let title = titlePostTF.text,
           let text = textPostTF.text,
           let url = ApiConstants.postPathURL {
            let post: [String: Any] = ["userId": userId,
                                       "title": title,
                                       "body": text]
            
           AF.request(url, method: .post, parameters: post, encoding: JSONEncoding.default)
                .responseJSON { response in
                    
                    debugPrint(response)
                    print(response.request as Any)
                    print(response.response as Any)
                    debugPrint(response.result)
                    
                    switch response.result {
                    case .success(let data):
                        print(data)
                        print(JSON(data))
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
}
