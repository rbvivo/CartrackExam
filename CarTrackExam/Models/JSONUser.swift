//
//  JSONUser.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

class JSONUser: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    init(id: Int, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
    
}

class Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}

// MARK: - Geo
class Geo: Codable {
    let lat: String
    let lng: String
    
    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}

// MARK: - Company
class Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
