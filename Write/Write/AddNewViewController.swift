//
//  AddNewViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit
import CoreLocation

class AddNewViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate {

    
    
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
        categoryLabel.delegate = self
        setCategoryPicker()
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
          createAlert(titleText:"Added succesfuly", messageText: "The item is added")
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


    func createAlert(titleText:String, messageText:String){
    let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Done", style: .default, handler: { (action) in alert.dismiss(animated:true, completion: nil)
    
    }
    ))
        self.present(alert, animated:true, completion: nil)
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















