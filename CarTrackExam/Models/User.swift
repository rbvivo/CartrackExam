//
//  User.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/14/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

class User {
    var id: Int
    var name: String
    var password: String
    
    init(id: Int, name: String, password: String) {
        self.id = id
        self.name = name
        self.password = password
    }
}
