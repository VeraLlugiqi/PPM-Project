//
//  HomeTwoViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit

class HomeTwoViewController: UIViewController {

    
    @IBOutlet weak var watchedName: UILabel!
    
    @IBOutlet weak var watchedCategory: UILabel!
    
    @IBOutlet weak var watchedDescription: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        watchedName.text = nameWatched[myIndexTwo]
        watchedCategory.text = categoryWatched[myIndexTwo]
        watchedDescription.text = descriptionWatched[myIndexTwo]

        // Do any additional setup after loading the view.
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
