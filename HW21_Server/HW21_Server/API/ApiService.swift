//
//  ApiService.swift
//  HW21_Server
//
//  Created by Nata on 27.07.2021.
//

import Alamofire
import SwiftyJSON
import Foundation

class ApiService {

static func deleteComment(idComment: Int, callback: @escaping (_ result: JSON?, _ error: Error?) -> Void) {
    
    let url = ApiConstants.commentsPath + "/" + "\(idComment)"
    
    AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
        var value: JSON?
        var err: Error?
        
        switch response.result {
        case .success(let a):
            value = JSON(a)
        case .failure(let error):
            err = error
        }
        callback(value, err)
    }
}
}
