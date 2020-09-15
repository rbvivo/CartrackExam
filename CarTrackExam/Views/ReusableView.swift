//
//  ReusableView.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import UIKit

public protocol ReusableView {
    static var defaultReuseIdentifier: String {
        get
    }
}

extension ReusableView where Self: UIView{
    public static var defaultReuseIdentifier: String{
        return String(describing: self)
    }
}
