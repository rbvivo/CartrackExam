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
    
    private func configureUI() {
        if nameLabel.superview == nil {
            contentView.addSubview(nameLabel)
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
    }

    func configureCell(user: JSONUser) {
        configureUI()
        nameLabel.text = user.name
    }
}
