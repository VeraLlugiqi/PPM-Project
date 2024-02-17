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
    
 
    
    var myIndexTwo = 0
    let dbConnect = DBConnect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbConnect.openDatabase()
        fetchWatchedData()
        dbConnect.closeDatabase()
    }
    
    

    
    func fetchWatchedData() {
        let query = "SELECT Name, Category, Description FROM Watched WHERE ID = ?"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(dbConnect.db, query, -1, &queryStatement, nil) == SQLITE_OK {
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
