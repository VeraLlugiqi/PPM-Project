//
//  HomeViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//





import UIKit
import SQLite3

class HomeViewController: UIViewController {
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    var db: OpaquePointer? // Database connection
    var myIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabase()
        fetchToWatchData()
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
            sqlite3_bind_int(queryStatement, 1, Int32(myIndex + 2))

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 0))
                let category = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))

                nameLabel.text = name
                categoryLabel.text = category
                descriptionLabel.text = description
            }
        }

        sqlite3_finalize(queryStatement)
    }

    @IBAction func yesButton(_ sender: Any) {
        insertData()
        createAlert(titleText: "Added successfully", messageText: "The item is added to your list.")
    }

    func insertData() {
        let insertStatementString = "INSERT INTO Watched (Name, Category, Description) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let name = nameLabel.text ?? ""
            let category = categoryLabel.text ?? ""
            let description = descriptionLabel.text ?? ""

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
}

