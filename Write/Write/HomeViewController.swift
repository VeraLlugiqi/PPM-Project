//
//  HomeViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController{

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = namesKos[myIndex]
        categoryLabel.text = categorysKos[myIndex]
        descriptionLabel.text = descriptionsKos[myIndex]
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func yesButton(_ sender: Any) {
        createAlert(titleText:"Added succesfuly", messageText: "The item is added to ")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func createAlert(titleText:String, messageText:String){
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Done", style: .default, handler: { (action) in alert.dismiss(animated:true, completion: nil)
            
        }
        ))
        self.present(alert, animated:true, completion: nil)
    }

}


