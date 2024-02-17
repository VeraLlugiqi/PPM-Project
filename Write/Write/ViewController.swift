//
//  ViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            var category: String?
            switch identifier {
            case "MoviesSegue":
                category = "Movies"
            case "SeriesSegue":
                category = "Series"
            case "ShowsSegue":
                category = "Shows"
            case "DocumentariesSegue":
                category = "Documentaries"
            case "OthersSegue":
                category = "Others"
            default:
                break
            }
            
            if let destinationVC = segue.destination as? ButtonsToWatchViewController, let category = category {
                destinationVC.selectedCategory = category
            }
        }
    }
}

