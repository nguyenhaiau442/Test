//
//  LoginViewModel.swift
//  Test
//
//  Created by Nguyễn Hải Âu on 10/21/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import Foundation
import Alamofire

let isLogged = "isLogged"

enum LoginResult {
    case success(String)
    case failure(Bool, String)
}

final class LoginViewModel {
    
    var email: String = ""
    var password: String = ""
    
    let userDefault = UserDefaults.standard
    
    func login(email: String, password: String, completion: @escaping (LoginResult) -> ()) {
        guard let url = URL(string: "http://yelp-test.kennjdemo.com/api/v1/user/login") else { return }
        let parameters: Parameters = ["email": email, "password": password]
        AF.request(url, method: .post, parameters: parameters).responseJSON { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let json):
                if let dict = json as? [String: Any] {
                    let result = dict["result"] as! Bool
                    let message = dict["message"] as! String
                    if result == true {
                        if let data = dict["data"] as? [String: Any] {
                            let accessToken = data["access_token"] as! String
                            DataManager.shared().saveAccessToken(accessToken: accessToken)
                        }
                        self.userDefault.set(true, forKey: isLogged)
                        completion(.success(message))
                    } else {
                        completion(.failure(true, message))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
