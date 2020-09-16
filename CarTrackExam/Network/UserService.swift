//
//  UserService.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import Foundation

protocol UserServiceProviding {
    func getUsers(completion: @escaping (APIResponse<Data>) -> Void)
}

struct UserService: UserServiceProviding {

    func getUsers(completion: @escaping (APIResponse<Data>) -> Void) {
        guard let url = URL(string: "\(APIEndpoint.baseURL.rawValue)\(APIEndpoint.users.rawValue)") else {return}
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "Connection error", code: -1, userInfo: nil)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
