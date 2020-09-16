//
//  DBHelper.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/14/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper {
    
    let dbPath: String = "cartrackDb.sqlite"
    var db:OpaquePointer?
    
    var verifySuccess: (() -> Void)?
    var verifyFailed: (() -> Void)?
    
    init() {
        db = openDatabase()
        createTable()
        insert(id: 1, name: "TestUser", password: "Test123!", country: "Philippines")
    }
    
    private func openDatabase() -> OpaquePointer?
    {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(dbPath)
            
            var db: OpaquePointer? = nil
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                return nil
            }
            else {
                return db
            }
        } catch {
            return nil
        }
        
    }
    
    private func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS user(Id INTEGER PRIMARY KEY, name TEXT, password TEXT, country TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("user table created.")
            } else {
                print("user table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    private func insert(id: Int, name: String, password: String, country: String) {
      
        let insertStatementString = "INSERT OR IGNORE INTO user (Id, name, password, country) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (country as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
    func verifyUser(name: String, password: String, country: String) {
        let queryStatementString = "SELECT * FROM user Where name = ? And password = ? And country = ?;"
        var queryStatement: OpaquePointer? = nil
        var users : [User] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 3, (country as NSString).utf8String, -1, nil)
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                users.append(User(id: Int(id), name: name, password: password, country: country))
            }
        }
        
        sqlite3_finalize(queryStatement)
        DispatchQueue.main.async { [weak self] in
            if users.count > 0 {
                self?.verifySuccess?()
            } else {
                self?.verifyFailed?()
            }
        }
    }
}
