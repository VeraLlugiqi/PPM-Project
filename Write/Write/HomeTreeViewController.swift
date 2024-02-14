//
//  HomeTreeViewController.swift
//  Write
//
//  Created by O on 04/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//
//
//import UIKit
//
//class HomeTreeViewController: UIViewController {
//    
//    @IBOutlet weak var NameLabelButtons: UILabel!
//    
//    @IBOutlet weak var CategoryLabelButtons: UILabel!
//    
//   
//    @IBOutlet weak var DescriptionLabelButtons: UILabel!
//    
//    
//    @IBOutlet weak var YesButtons: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        NameLabelButtons.text = nameToWatchB[myIndexThree]
//        CategoryLabelButtons.text = categoryToWatchB[myIndexThree]
//        DescriptionLabelButtons.text = descriptionToWatchB[myIndexThree]
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
    
    func closeDatabase() {
        sqlite3_close(db)
    }
    
    func fetchToWatchData() {
        let query = "SELECT Name, Category, Description, Watched FROM toWatch WHERE rowid = ?"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(myIndexThree + 1))
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 0))
                let category = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                let watched = Int(sqlite3_column_int(queryStatement, 3)) // Fetch Watched column value
                
                nameLabelButtons.text = name
                categoryLabelButtons.text = category
                descriptionLabelButtons.text = description
                
                // Display Watched status based on the value of the Watched column
                watchedStatusLabel.text = watched == 1 ? "Watched" : "Not Watched"
            }
        }
        
        sqlite3_finalize(queryStatement)
    }
}
