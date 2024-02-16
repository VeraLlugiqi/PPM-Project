//
//  ButtonsToWatchViewController.swift
//  Write
//
//  Created by O on 04/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.

//import UIKit
//import SQLite3
//
//  var myIndexThree = 0
//
//class ButtonsToWatchViewController: UIViewController {
//
//    @IBOutlet weak var TableButtons: UITableView!
//
//    var nameToWatchB = [String]()
//    var categoryToWatchB = [String]()
//    var descriptionToWatchB = [String]()
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchDataFromDatabase()
//    }
//
//    func fetchDataFromDatabase() {
//        // Get the path to the database file
//        guard let dbPath = Bundle.main.path(forResource: "WriteITDb", ofType: "db") else {
//            print("Database file not found.")
//            return
//        }
//
//        // Open a connection to the database
//        var db: OpaquePointer?
//        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
//            print("Error opening database.")
//            return
//        }
//        defer { sqlite3_close(db) }
//
//        // Prepare the SQL query
//        var statement: OpaquePointer?
//        let query = "SELECT Name, Category, Description FROM toWatch WHERE category = ? AND IsWatched = ?;"
//        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
//            let category: NSString = "Movies" // Change this to "Series", "Shows", etc. based on the button tapped
//            let isWatched: NSString = "No"
//            sqlite3_bind_text(statement, 1, category.utf8String, -1, nil)
//            sqlite3_bind_text(statement, 2, isWatched.utf8String, -1, nil)
//
//            // Execute the query and iterate over the results
//            while sqlite3_step(statement) == SQLITE_ROW {
//                if let name = sqlite3_column_text(statement, 0),
//                   let category = sqlite3_column_text(statement, 1),
//                   let description = sqlite3_column_text(statement, 2) {
//                    nameToWatchB.append(String(cString: name))
//                    categoryToWatchB.append(String(cString: category))
//                    descriptionToWatchB.append(String(cString: description))
//                    print("Number of fetched rows: \(nameToWatchB.count)")                            }
//            }
//        } else {
//            print("Error preparing query.")
//        }
//        sqlite3_finalize(statement)
//
//        // Reload table view data after fetching data from the database
//        DispatchQueue.main.async {
//            self.TableButtons.reloadData()
//        }
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           if segue.identifier == "homeThree" {
//               if let destinationVC = segue.destination as? HomeViewController {
//                   destinationVC.myIndex = MyIndex
//               }
//           }
//       }
//
//}
//
//extension ButtonsToWatchViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return nameToWatchB.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellTwo = TableButtons.dequeueReusableCell(withIdentifier: "cellThree", for: indexPath)
//        cellTwo.textLabel?.text = nameToWatchB[indexPath.row]
//        return cellTwo
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Perform actions when a row is selected
//          myIndexThree  = indexPath.row;
//        TableButtons.deselectRow(at: indexPath, animated: true)
//        performSegue(withIdentifier: "homeThree", sender: self)
//
//    }
//}
import UIKit
import SQLite3

var myIndexThree = 0

class ButtonsToWatchViewController: UIViewController {
    
    @IBOutlet weak var TableButtons: UITableView!
    
    var nameToWatchB = [String]()
    var categoryToWatchB = [String]()
    var descriptionToWatchB = [String]()
    
    // Variable to hold the selected category
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchDataFromDatabase()
        if let category = selectedCategory {
                   print("Selected category: \(category)")
                   // Use category as needed
               } else {
                   print("No category selected")
               }
    }
    

    
    func fetchDataFromDatabase() {
        // Get the path to the database file
        guard let dbPath = Bundle.main.path(forResource: "WriteITDb", ofType: "db") else {
            print("Database file not found.")
            return
        }
        
        // Open a connection to the database
        var db: OpaquePointer?
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            print("Error opening database.")
            return
        }
        defer { sqlite3_close(db) }
        
        // Prepare the SQL query
        var statement: OpaquePointer?
        print("iside the function")
        let query = "SELECT Name, Category, Description FROM toWatch WHERE Category = ? AND IsWatched = ?;"
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
//            print("inside the first if")
            // Use the selected category for filtering
//            print(selectedCategory)
            if let category = selectedCategory {
                print("Inslide the if")
                let isWatched: NSString = "No"
                // Bind the values correctly
                sqlite3_bind_text(statement, 1, category, -1, nil)
                sqlite3_bind_text(statement, 2, isWatched.utf8String, -1, nil)
                
                // Execute the query and iterate over the results
                while sqlite3_step(statement) == SQLITE_ROW {
//                    print("inside the while")
                    if let name = sqlite3_column_text(statement, 0),
                       let category = sqlite3_column_text(statement, 1),
                       let description = sqlite3_column_text(statement, 2) {
                        nameToWatchB.append(String(cString: name))
                        categoryToWatchB.append(String(cString: category))
                        descriptionToWatchB.append(String(cString: description))
                        print("Number of fetched rows: \(nameToWatchB.count)")
                    }
                }
            }
        } else {
            print("Error preparing query: \(String(cString: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(statement)
        
        // Reload table view data after fetching data from the database
        DispatchQueue.main.async {
            self.TableButtons.reloadData()
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeThree" {
            if let destinationVC = segue.destination as? HomeTreeViewController {
                destinationVC.myIndexThree = myIndexThree
            }
        }
    }
}

extension ButtonsToWatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameToWatchB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTwo = TableButtons.dequeueReusableCell(withIdentifier: "cellThree", for: indexPath)
        cellTwo.textLabel?.text = nameToWatchB[indexPath.row]
        return cellTwo
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Perform actions when a row is selected
        myIndexThree = indexPath.row
        TableButtons.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "homeThree", sender: self)
    }
}
