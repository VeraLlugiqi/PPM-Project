//
//  HomeTwoViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//
//
import UIKit
import SQLite3

class HomeTwoViewController: UIViewController {
    @IBOutlet weak var watchedName: UILabel!
    @IBOutlet weak var watchedCategory: UILabel!
    @IBOutlet weak var watchedDescription: UILabel!
    
    var db: OpaquePointer? // Database connection
    
    var myIndexTwo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabase()
        fetchWatchedData()
        closeDatabase()
    }
    
    func openDatabase() {
           // Get the full path to the SQLite database file
           let dbFilePath = Bundle.main.path(forResource: "WriteITDb", ofType: "db")!
           
           // Open the database connection
           if sqlite3_open(dbFilePath, &db) != SQLITE_OK {
               print("Error opening database connection")
           }
       }
    
    func closeDatabase() {
        sqlite3_close(db)
    }
    
    func fetchWatchedData() {
        let query = "SELECT Name, Category, Description FROM Watched WHERE ID = ?"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(myIndexTwo + 1))
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 0))
                let category = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                
                watchedName.text = name
                watchedCategory.text = category
                watchedDescription.text = description
            }
        }
        
        sqlite3_finalize(queryStatement)
    }
}
