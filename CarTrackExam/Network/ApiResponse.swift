//
//  ApiResponse.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

enum APIResponse<T> {
    case success(T)
    case failure(Error)
}

