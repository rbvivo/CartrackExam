//
//  UserTableViewCell.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell, ReusableView {

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.numberOfLines = 0
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
    
    private func configureUI() {
        if nameLabel.superview == nil {
            contentView.addSubview(nameLabel)
            contentView.addSubview(emailLabel)
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                
                emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
    }

    func configureCell(user: JSONUser) {
        configureUI()
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
}
