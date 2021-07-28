//
//  ApiConstants.swift
//  HW21_Server
//
//  Created by Nata on 27.07.2021.
//

import Foundation

class ApiConstants {
    // server
    static let serverPath = "http://localhost:3000/"
    
    //posts
    static let postsPath = serverPath + "posts"
    static let postPathURL = URL(string: postsPath)
    
    //comments
    static let commentsPath = serverPath + "comments"
    static let commentsPathURL = URL(string: commentsPath)
}
