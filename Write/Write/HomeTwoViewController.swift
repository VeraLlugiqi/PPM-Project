//
//  HomeTwoViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//
//
//import UIKit
//
//class HomeTwoViewController: UIViewController {
//
//    
//    @IBOutlet weak var watchedName: UILabel!
//    
//    @IBOutlet weak var watchedCategory: UILabel!
//    
//    @IBOutlet weak var watchedDescription: UILabel!
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        watchedName.text = nameWatched[myIndexTwo]
//        watchedCategory.text = categoryWatched[myIndexTwo]
//        watchedDescription.text = descriptionWatched[myIndexTwo]
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

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
        let query = "SELECT Name, Category, Description FROM Watched WHERE rowid = ?"
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
