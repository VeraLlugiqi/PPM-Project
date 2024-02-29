//
//  ToWatchViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//


import UIKit
import SQLite3

var MyIndex = 0;

class ToWatchViewController: UIViewController {
    
    @IBOutlet weak var toWatchTable: UITableView!
    
    var toWatchData = [(String, String, String, String)]()
    
    
    
    let dbConnect = DBConnect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbConnect.openDatabase()
        fetchToWatchData()
        dbConnect.closeDatabase()
        
        toWatchTable.reloadData()
    }
  
    
    func fetchToWatchData() {
        let query = "SELECT Name, Category, Description,IsWatched FROM toWatch"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(dbConnect.db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 0))
                let category = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                 let iswatched = String(cString: sqlite3_column_text(queryStatement, 3))
                
                toWatchData.append((name, category, description,iswatched))
            }
        }
        
        sqlite3_finalize(queryStatement)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            if let destinationVC = segue.destination as? HomeViewController {
                destinationVC.myIndex = MyIndex
            }
        }
    }


}

extension ToWatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toWatchData.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celliii", for: indexPath) as! CustomTableViewCell
        
        let toWatchItem = toWatchData[indexPath.row]
        
    
        cell.TitleLabel.text = toWatchItem.0
        cell.CategoryLabel.text = toWatchItem.1 
        
        return cell
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MyIndex = indexPath.row;
//        toWatchTable.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "home", sender: self)
        
    }
}
