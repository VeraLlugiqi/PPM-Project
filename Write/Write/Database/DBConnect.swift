//
//  DBConnect.swift
//  Write
//
//  Created by MacbookPro on 17/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import Foundation
import UIKit
import SQLite3

class DBConnect {
    var db: OpaquePointer? // Database connection

    
//    func openDatabase() -> Bool {
//        guard let dbFilePath = Bundle.main.path(forResource: "WriteITDb", ofType: "db") else {
//            print("Database file not found.")
//            return false
//        }
//
//        if sqlite3_open(dbFilePath, &db) == SQLITE_OK {
//            print("Successfully opened connection to database.")
//            return true
//        } else {
//            print("Error opening database connection")
//            return false
//        }
//    }
//
//    func closeDatabase() {
//        guard let database = db else {
//            return
//        }
//        sqlite3_close(database)
//        print("Database connection closed.")
//    }
    
    func openDatabase() {
        let dbFilePath = Bundle.main.path(forResource: "WriteITDb", ofType: "db")!
        
        if sqlite3_open(dbFilePath, &db) != SQLITE_OK {
            print("Error opening database connection")
        }
    }
    
    func closeDatabase() {
        sqlite3_close(db)
    }
}
