//
//  HomeTreeViewController.swift
//  Write
//
//  Created by O on 04/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit

class HomeTreeViewController: UIViewController {
    
    @IBOutlet weak var NameLabelButtons: UILabel!
    
    @IBOutlet weak var CategoryLabelButtons: UILabel!
    
   
    @IBOutlet weak var DescriptionLabelButtons: UILabel!
    
    
    @IBOutlet weak var YesButtons: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NameLabelButtons.text = nameToWatchB[myIndexThree]
        CategoryLabelButtons.text = categoryToWatchB[myIndexThree]
        DescriptionLabelButtons.text = descriptionToWatchB[myIndexThree]
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

}
