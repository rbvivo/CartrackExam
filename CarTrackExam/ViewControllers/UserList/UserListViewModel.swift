//
//  UserListViewModel.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import Foundation

class UserListViewModel {

    var users: [JSONUser] = []
    private let userServiceProviding: UserServiceProviding
    var isFetchingInProgress = false
    var fetchUsersCompleted: (() -> ())?
    var fetchUsersFailedHandler: ((_ error: Error) -> Void)?
    
    init(userServiceProviding: UserServiceProviding = UserService()) {
        self.userServiceProviding = userServiceProviding
    }
    
    func retrieveUsers() {
        guard !isFetchingInProgress else { return }
        self.isFetchingInProgress = true
        userServiceProviding.getUsers(completion: { [weak self] response in
            guard let `self` = self else { return }
            self.isFetchingInProgress = false
            switch response {
            case .success(let data):
                do {
                let decoder = JSONDecoder()
                    self.users = try decoder.decode(UserList.self, from: data)
                    self.fetchUsersCompleted?()
                } catch {
                     let error = NSError(domain: "Connection error", code: -1, userInfo: nil)
                     self.fetchUsersFailedHandler?(error)
                }
                    
            case .failure(let error):
                self.fetchUsersFailedHandler?(error)
            }
        })
    }
}
