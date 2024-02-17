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
    @IBOutlet weak var watchedStatusLabel: UILabel!
    
    var db: OpaquePointer?
    
    var myIndexThree = 0
    var id = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabase()
        fetchToWatchData()
       // closeDatabase()
        
    }
    
    func openDatabase() {
       
        let dbFilePath = Bundle.main.path(forResource: "WriteITDb", ofType: "db")!
        
   
        if sqlite3_open(dbFilePath, &db) != SQLITE_OK {
            print("Error opening database connection")
        }
    }
    
    @IBAction func yesButton(_ sender: Any) {
        
        createAlert(titleText: "Added successfully", messageText: "The item is added to your Watched list.")
        insertData()
        deleteFromToWatch()
    }
    
    
    func fetchToWatchData() {
        var query = "SELECT Name, Category, Description FROM toWatch WHERE ID IN ("
        query += id.map { String($0) }.joined(separator: ",")
        query += ");"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(queryStatement, 1, Int32(myIndexThree + 2))

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
    func insertData() {
        let insertStatementString = "INSERT INTO Watched (Name, Category, Description) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let name = nameLabelButtons.text ?? ""
            let category = categoryLabelButtons.text ?? ""
            let description = descriptionLabelButtons.text ?? ""

            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (category as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (description as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("Error inserting row into Watched table")
            }
        }

        sqlite3_finalize(insertStatement)
    }

    func createAlert(titleText: String, messageText: String) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    deinit {
        sqlite3_close(db)
    }
    
        func deleteFromToWatch() {
        let deleteStatementString = "DELETE FROM toWatch WHERE Name = ? AND Category = ? AND Description = ?;"
        var deleteStatement: OpaquePointer?
    
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            let name = nameLabelButtons.text ?? ""
            let category = categoryLabelButtons.text ?? ""
            let description = descriptionLabelButtons.text ?? ""
    
            sqlite3_bind_text(deleteStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(deleteStatement, 2, (category as NSString).utf8String, -1, nil)
            sqlite3_bind_text(deleteStatement, 3, (description as NSString).utf8String, -1, nil)
    
            if sqlite3_step(deleteStatement) != SQLITE_DONE {
                print("Error deleting row from toWatch table")
            }
        }
    
        sqlite3_finalize(deleteStatement)
          }}
