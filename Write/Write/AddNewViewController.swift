//
//  AddNewViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit
import CoreLocation
import SQLite3

class AddNewViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var nameText: UITextField!
    

    @IBOutlet weak var descriptionText: UITextView!
    

   

    @IBOutlet weak var categoryLabel: UITextField!

    lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
    }()

    let categoryValues = ["Movies", "Series", "Shows", "Documentaries", "Others"]
    var categoryName: String = "NA"

    var db: OpaquePointer?

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.delegate = self
        setCategoryPicker()
        openDatabase()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        closeDatabase()
    }

    func setCategoryPicker() {
        let doneBar = UIToolbar()
        doneBar.tintColor = ShareFunc.UIColorFromHex(rgbValue: 0x34869, alpha: 0.1)
        doneBar.layer.borderWidth = 1
        doneBar.layer.borderColor = ShareFunc.UIColorFromHex(rgbValue: 0xE6E6E6, alpha: 1).cgColor
        doneBar.sizeToFit()

        let alignSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(categoryPickerDone))

        doneBar.setItems([alignSpace, done], animated: false)

        categoryLabel.inputView = categoryPicker
        categoryLabel.inputAccessoryView = doneBar
    }


    
    func openDatabase() {
        // Get the full path to the SQLite database file
        let dbFilePath = Bundle.main.path(forResource: "WriteITDb", ofType: "db")!

        // Open the database connection
        if sqlite3_open(dbFilePath, &db) != SQLITE_OK {
            print("Error opening database connection")
            return
        }
        
        // Start a transaction
        let beginSQL = "BEGIN TRANSACTION;"
        if sqlite3_exec(db, beginSQL, nil, nil, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("Error starting transaction: \(errorMessage)")
        }
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker {
            return categoryValues.count
        }
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker{
            return categoryValues[row]
        }
        return categoryValues[row]
    }


    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker{
            categoryLabel.text = categoryValues[row]
            categoryName = categoryValues[row]
        }

    }

    func closeDatabase() {
        sqlite3_close(db)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == categoryLabel){
            categoryPickerDone()
        }
    }
    @objc func categoryPickerDone() {
        switch categoryName {
        case "Movies", "Series", "Shows", "Documentaries", "Others":
            print(categoryName)
        default:
            print("Unknown category")
        }
        categoryLabel.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func addButton(_ sender: Any) {
//          createAlert(titleText:"Added succesfuly", messageText: "The item is added")
         insertData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//    override func viewDidAppear(_ animated: Bool) {
//        createAlert(titleText:"Added succesfuly", messageText: "Added")
//    }

    func createAlert(titleText: String, messageText: String) {
        // Dismiss any existing UIAlertController
        if let presentedViewController = self.presentedViewController {
            presentedViewController.dismiss(animated: false, completion: {
                self.presentAlertController(titleText: titleText, messageText: messageText)
            })
        } else {
            presentAlertController(titleText: titleText, messageText: messageText)
        }
    }

    private func presentAlertController(titleText: String, messageText: String) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    
    func insertData() {
        // Prepare the SQL statement for insertion
        let insertStatementString = "INSERT INTO toWatch (Name, Category, Description, IsWatched) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer?

        // Prepare the SQL statement
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            // Bind parameters to the SQL statement
            let name = nameText.text ?? ""
            let category = categoryLabel.text ?? ""
            let description = descriptionText.text ?? ""
            let isWatched = "No" // Set default value for IsWatched column

            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (category as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (isWatched as NSString).utf8String, -1, nil)

            // Execute the SQL statement
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                createAlert(titleText: "Added successfully", messageText: "The item is added")
                
                // Commit the transaction to save changes
                let commitSQL = "COMMIT TRANSACTION;"
                if sqlite3_exec(db, commitSQL, nil, nil, nil) != SQLITE_OK {
                    let errorMessage = String(cString: sqlite3_errmsg(db)!)
                    print("Error committing transaction: \(errorMessage)")
                }
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(db)!)
                print("Error inserting row: \(errorMessage)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing insert statement: \(errorMessage)")
        }

        // Finalize the statement to release resources
        sqlite3_finalize(insertStatement)
    }





}
class ShareFunc : UIViewController,CLLocationManagerDelegate{
    class func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)-> UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 16)/256.0
        let blue = CGFloat((rgbValue & 0x0000FF) >> 16)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}


