//
//  HomeViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//
//
//import UIKit
//
//
//class HomeViewController: UIViewController{
//
//    @IBOutlet weak var yesButton: UIButton!
//    @IBOutlet weak var questionLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var categoryLabel: UILabel!
//    @IBOutlet weak var nameLabel: UILabel!
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        nameLabel.text = namesKos[myIndex]
//        categoryLabel.text = categorysKos[myIndex]
//        descriptionLabel.text = descriptionsKos[myIndex]
//        
//        
//        
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    
//    @IBAction func yesButton(_ sender: Any) {
//        createAlert(titleText:"Added succesfuly", messageText: "The item is added to ")
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
//    func createAlert(titleText:String, messageText:String){
//        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title:"Done", style: .default, handler: { (action) in alert.dismiss(animated:true, completion: nil)
//            
//        }
//        ))
//        self.present(alert, animated:true, completion: nil)
//    }
//
//}
//
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
        let query = "SELECT name, category, description FROM toWatch WHERE rowid = ?"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(myIndex + 1))
            
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
        createAlert(titleText: "Added successfully", messageText: "The item is added to your list.")
    }
    
    func createAlert(titleText: String, messageText: String) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

