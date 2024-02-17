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
    

    let dbConnect = DBConnect()
    
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



    override func viewDidLoad() {
        super.viewDidLoad()
        dbConnect.openDatabase()

        categoryLabel.delegate = self
        setCategoryPicker()
            }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dbConnect.closeDatabase()
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
         insertData()
    }

    
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
        let insertStatementString = "INSERT INTO toWatch (Name, Category, Description, IsWatched) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer?

        // Prepare the SQL statement
        if sqlite3_prepare_v2(dbConnect.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let name = nameText.text ?? ""
            let category = categoryLabel.text ?? ""
            let description = descriptionText.text ?? ""
            let isWatched = "No"

            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (category as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (isWatched as NSString).utf8String, -1, nil)

         
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                createAlert(titleText: "Added successfully", messageText: "The item is added")
                
                let commitSQL = "COMMIT TRANSACTION;"
                if sqlite3_exec(dbConnect.db, commitSQL, nil, nil, nil) != SQLITE_OK {
                    let errorMessage = String(cString: sqlite3_errmsg(dbConnect.db)!)
                    print("Error committing transaction: \(errorMessage)")
                }
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(dbConnect.db)!)
                print("Error inserting row: \(errorMessage)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(dbConnect.db)!)
            print("Error preparing insert statement: \(errorMessage)")
        }

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


