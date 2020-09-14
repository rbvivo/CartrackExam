//
//  LoginViewModel.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/14/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

class LoginViewModel {
  let dbHelper: DBHelper = DBHelper()
    var verifySuccess: (() -> Void)?
    var verifyFailed: (() -> Void)?
    
    func login(name: String, password: String) {
        dbHelper.verifyUser(name: name, password: password)
        dbHelper.verifySuccess = { [weak self] in
            self?.verifySuccess?()
        }
        dbHelper.verifyFailed = { [weak self] in
            self?.verifyFailed?()
        }
    }
}
