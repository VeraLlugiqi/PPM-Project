//
//  ButtonsToWatchViewController.swift
//  Write
//
//  Created by O on 04/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.

import UIKit
import SQLite3

var myIndexThree = 0

class ButtonsToWatchViewController: UIViewController {
    
    @IBOutlet weak var TableButtons: UITableView!
    
    var nameToWatchB = [String]()
    var categoryToWatchB = [String]()
    var descriptionToWatchB = [String]()
    var id = [Int]()
    
    var selectedCategory: String?
    
     var db: OpaquePointer?
    override func viewDidLoad() {
        super.viewDidLoad()
        openDatabase()
        fetchDataFromDatabase()
        if let category = selectedCategory {
                   print("Selected category: \(category)")
              
               } else {
                   print("No category selected")
               }
        closeDatabase()
    }
    

    func openDatabase() {
        let dbFilePath = Bundle.main.path(forResource: "WriteITDb", ofType: "db")!
        
        if sqlite3_open(dbFilePath, &db) != SQLITE_OK {
            print("Error opening database connection")
        }
    }
    
    func closeDatabase() {
        sqlite3_close(db)
    }
    func fetchDataFromDatabase() {
      
    
        
      
        var statement: OpaquePointer?
        print("iside the function")
        let query = "SELECT Name, Category, Description, ID FROM toWatch WHERE Category = ? AND IsWatched = ?;"
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
//            print("inside the first if")
            if let category = selectedCategory {
                print("Inslide the if")
                let isWatched: NSString = "No"
                // Bind the values correctly
                sqlite3_bind_text(statement, 1, category, -1, nil)
                sqlite3_bind_text(statement, 2, isWatched.utf8String, -1, nil)
                
            
                while sqlite3_step(statement) == SQLITE_ROW {
//                    print("inside the while")
                    if let name = sqlite3_column_text(statement, 0),
                       let category = sqlite3_column_text(statement, 1),
                        let description = sqlite3_column_text(statement, 2){
                        let idd = Int(sqlite3_column_int(statement, 3)) ;        id.append(idd)           ; nameToWatchB.append(String(cString: name))
                        categoryToWatchB.append(String(cString: category))
                        id.append(Int(idd))
                        descriptionToWatchB.append(String(cString: description))
                        print("Number of fetched rows: \(nameToWatchB.count)")
                    }
                }
            }
        } else {
            print("Error preparing query: \(String(cString: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(statement)

        DispatchQueue.main.async {
            self.TableButtons.reloadData()
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeThree" {
            if let destinationVC = segue.destination as? HomeTreeViewController {
                destinationVC.myIndexThree = myIndexThree
                destinationVC.id = id
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
        myIndexThree = indexPath.row
        TableButtons.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "homeThree", sender: self)
    }
}
