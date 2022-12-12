//
//  ApiManager.swift
//  CatsFinderAppUI
//
//  Created by Артем Соловьев on 09.11.2022.
//

import Alamofire
import Foundation

var baseLocalUrl: String {
    return "http://46.101.193.132:8080/cats/api/v1.0/"
}

var postsUrl: String {
    return "posts"
}

class ApiManager {
    static let shared = ApiManager()
    
    func getAllPosts(completion: @escaping ([Posts]) -> Void) {
        AF.request(baseLocalUrl + postsUrl).response { responseData in
            guard let data = responseData.data else { return }
            if let token = try? JSONDecoder().decode([Posts].self, from: data) {
                completion(token)
            } else {
                print("Parse Error")
            }
        }
    }
    
    func addPost(_ parametrs: [String:Any]) {
        AF.request(baseLocalUrl + postsUrl, method: .post, parameters: parametrs).response { response in
            print(response)
        }
    }
    
    func delPost(_ id: String) {
        AF.request(baseLocalUrl + postsUrl + "/" + id, method: .delete).response { response in
            print(response)
        }
    }
}
