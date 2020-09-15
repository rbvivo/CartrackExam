//
//  CountryTableViewCell.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell, ReusableView {

    private lazy var countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.numberOfLines = 0
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryLabel
    }()
    
    private func configureUI() {
        if countryLabel.superview == nil {
            contentView.addSubview(countryLabel)
            NSLayoutConstraint.activate([
                countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                countryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                countryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
    }
    
    func setCountryText(countryText: String) {
        configureUI()
        countryLabel.text = countryText
    }

}
