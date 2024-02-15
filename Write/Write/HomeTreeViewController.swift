//
//  HomeTreeViewController.swift
//  Write
//
//  Created by O on 04/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit
import SQLite3

class HomeTreeViewController: UIViewController {
    @IBOutlet weak var nameLabelButtons: UILabel!
    @IBOutlet weak var categoryLabelButtons: UILabel!
    @IBOutlet weak var descriptionLabelButtons: UILabel!
    @IBOutlet weak var watchedStatusLabel: UILabel! // Added label to display Watched status
    
    var db: OpaquePointer? // Database connection
    
    var myIndexThree = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabase()
        fetchToWatchData()
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
    
    
    
    func fetchToWatchData() {
        let query = "SELECT Name, Category, Description FROM toWatch WHERE ID = ?"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(myIndexThree + 2))

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 0))
                let category = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))

                nameLabelButtons.text = name
                categoryLabelButtons.text = category
                descriptionLabelButtons.text = description
                print(nameLabelButtons)
                print(categoryLabelButtons)
                print(descriptionLabelButtons)
            }
        }

        sqlite3_finalize(queryStatement)
    }
    func closeDatabase() {
        sqlite3_close(db)
    }
}
