//
//  WatchedViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit
import SQLite3

var MyIndexTwo = 0;
class WatchedViewController: UIViewController {
    @IBOutlet weak var watchedTable: UITableView!
    
    var watchedData = [(String, String, String)]() // Array to hold fetched data
    
    var db: OpaquePointer? // Database connection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabase()
        fetchWatchedData()
        
        if let scrollView = self.view.subviews.first as? UIScrollView {
                   scrollView.bounces = false
               }
    }
  
    func openDatabase() {
        // Get the full path to the SQLite database file
        let dbFilePath = Bundle.main.path(forResource: "WriteITDb", ofType: "db")!
        
        // Open the database connection
        if sqlite3_open(dbFilePath, &db) != SQLITE_OK {
            print("Error opening database connection")
        }
    }
    
    deinit {
        closeDatabase()
    }
    
    func closeDatabase() {
        sqlite3_close(db)
    }
    
    func fetchWatchedData() {
        let query = "SELECT Name, Category, Description FROM Watched"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 0))
                let category = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                watchedData.append((name, category, description))
                print("Number of fetched rows: \(watchedData.count)")
            }
            print("Number of fetched rows: \(watchedData.count)")
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing statement: \(errorMessage)")
        }
        
        sqlite3_finalize(queryStatement)
        watchedTable.reloadData() // Reload table view after fetching all data
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "homeTwo" {
               if let destinationVC = segue.destination as? HomeTwoViewController {
                   destinationVC.myIndexTwo = MyIndexTwo
               }
           }
       }
}

extension WatchedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath)
        
        let watchedItem = watchedData[indexPath.row]
        cell.textLabel?.text = watchedItem.0 // Display name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Perform actions when a row is selected
        MyIndexTwo = indexPath.row;
              watchedTable.deselectRow(at: indexPath, animated: true)
              performSegue(withIdentifier: "homeTwo", sender: self)
    }
}

