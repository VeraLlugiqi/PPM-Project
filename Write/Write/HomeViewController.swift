//
//  HomeViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//





import UIKit
import SQLite3
let dbConnect = DBConnect()

class HomeViewController: UIViewController {
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

  
    var myIndex = 0
  


    override func viewDidLoad() {
        super.viewDidLoad()
        dbConnect.openDatabase()
        fetchToWatchData()
        
    }


 @IBAction func yesButton(_ sender: Any) {
       
    if let presentedViewController = self.presentedViewController {
            presentedViewController.dismiss(animated: false) {
                self.presentAlert()
            }
        } else {
//            self.presentAlert()
        }
           insertData()
           deleteFromToWatch()
     
    }
    
    func presentAlert() {
        let alertController = UIAlertController(title: "Moved Successfully", message: "Your item has been moved to Watched list!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
    func fetchToWatchData() {
        let query = "SELECT Name, Category, Description FROM toWatch WHERE ID = ?"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(dbConnect.db, query, -1, &queryStatement, nil) == SQLITE_OK {
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

    
    
    func deleteFromToWatch() {
        let deleteStatementString = "DELETE FROM toWatch WHERE Name = ? AND Category = ? AND Description = ?;"
        var deleteStatement: OpaquePointer?
    
        if sqlite3_prepare_v2(dbConnect.db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            let name = nameLabel.text ?? ""
            let category = categoryLabel.text ?? ""
            let description = descriptionLabel.text ?? ""
    
            sqlite3_bind_text(deleteStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(deleteStatement, 2, (category as NSString).utf8String, -1, nil)
            sqlite3_bind_text(deleteStatement, 3, (description as NSString).utf8String, -1, nil)
    
            if sqlite3_step(deleteStatement) != SQLITE_DONE {
                print("Error deleting row from toWatch table")
            }
        }
    
        sqlite3_finalize(deleteStatement)
          }
    
    
    func insertData() {
        
        let insertStatementString = "INSERT INTO Watched (Name, Category, Description) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer?

        if sqlite3_prepare_v2(dbConnect.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
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


    deinit {
        sqlite3_close(dbConnect.db)
    }
}

