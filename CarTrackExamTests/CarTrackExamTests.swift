//
//  CarTrackExamTests.swift
//  CarTrackExamTests
//
//  Created by Bryan Vivo on 9/14/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import XCTest
@testable import CarTrackExam

class CarTrackExamTests: XCTestCase {

    func testVerifyUser() {
        let expection = expectation(description: "Expecting to be able to login")
        let viewModel = LoginViewModel()
        viewModel.login(name: "TestUser", password: "Test123!", country: "Philippines")
        viewModel.verifySuccess = {
            expection.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testVerifyUserFailed() {
        let expection = expectation(description: "Expecting to not be able to login")
        let viewModel = LoginViewModel()
        viewModel.login(name: "TestUser", password: "Test", country: "United States")
        viewModel.verifyFailed = {
            expection.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testRetrieveUsers() {
        let expection = expectation(description: "Expecting to get users from api")
        let viewModel = UserListViewModel()
        viewModel.retrieveUsers()
        viewModel.fetchUsersCompleted = {
            XCTAssertGreaterThan(viewModel.users.count, 0)
            expection.fulfill()
        }
        waitForExpectations(timeout: 20)
    }
    
    func testCountrySearch() {
        let viewModel = CountryListViewModel()
        viewModel.searchCountry(searchText: "Singapore")
        XCTAssertEqual("Singapore", viewModel.searchList.first)
    }
    
    func testCountrySearchFailed() {
        let viewModel = CountryListViewModel()
        viewModel.searchCountry(searchText: "1234")
        XCTAssertTrue(viewModel.searchList.count == 0)
    }
}
