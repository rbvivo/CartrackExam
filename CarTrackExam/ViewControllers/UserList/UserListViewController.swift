//
//  UserListViewController.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    let viewModel: UserListViewModel = UserListViewModel()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.registerCell(UserTableViewCell.self)
        tableView.separatorColor = .separator
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(user: viewModel.users[indexPath.row])
        return cell
    }
}

