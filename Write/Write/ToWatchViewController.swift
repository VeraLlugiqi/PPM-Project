//
//  ToWatchViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

//import UIKit
//
//var namesKos = ["IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie"]
//var categorysKos = ["Movie","Series","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie",]
//var descriptionsKos = ["bfjk sjkvbd dhbs dsbjbvs","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie",]
//var myIndex = 0
//
//
//class ToWatchViewController: UIViewController {
//
//    @IBOutlet weak var ToWatchTable: UITableView!
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
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
//
//extension ToWatchViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return namesKos.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = ToWatchTable.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
//    
//        cell.textLabel?.text = namesKos[indexPath.row]
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        myIndex = indexPath.row
//        
//        // Deselect the row with animation
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        // Perform the segue
//        performSegue(withIdentifier: "home", sender: self)
//    }
//    
//    
//    
//    
//}
import UIKit
import SQLite3

class ToWatchViewController: UIViewController {
    @IBOutlet weak var toWatchTable: UITableView!
    
    var toWatchData = [(String, String, String, String)]() // Array to hold fetched data (including Watched column)
    
    var db: OpaquePointer? // Database connection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabase()
        fetchToWatchData()
        closeDatabase()
        
        toWatchTable.reloadData() // Reload table view after fetching data
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
        let query = "SELECT Name, Category, Description,IsWatched FROM toWatch"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
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
}

extension ToWatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toWatchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celliii", for: indexPath)
        
        let toWatchItem = toWatchData[indexPath.row]
        cell.textLabel?.text = toWatchItem.0 // Display name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Perform actions when a row is selected
    }
}
