//
//  ViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBAction func moviesssButton(_ sender: Any) {
//    }
//
//    @IBAction func seriesssButton(_ sender: Any) {
//    }
//    @IBAction func showsssButton(_ sender: Any) {
//    }
//    @IBAction func documentariesssButton(_ sender: Any) {
//    }
//    @IBAction func othersssButton(_ sender: Any) {
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//}
//
//import UIKit
//
//class ViewController: UIViewController {
//
//
//    @IBAction func moviesButton(_ sender: Any) {
//        navigateToButtonsToWatch(withCategory: "Movies")
//        print("Clicked movies")
//    }
//
//    @IBAction func seriesButton(_ sender: Any) {
//        navigateToButtonsToWatch(withCategory: "Series")
//    }
//
//    @IBAction func showsButton(_ sender: Any) {
//        navigateToButtonsToWatch(withCategory: "Shows")
//    }
//
//    @IBAction func documentariesButton(_ sender: Any) {
//        navigateToButtonsToWatch(withCategory: "Documentaries")
//    }
//
//    @IBAction func otherButton(_ sender: Any) {
//        navigateToButtonsToWatch(withCategory: "Others")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
////    private func navigateToButtonsToWatch(withCategory category: String) {
////           if let buttonsToWatchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ButtonsToWatchViewController") as? ButtonsToWatchViewController {
////               buttonsToWatchVC.selectedCategory = category
////               navigationController?.pushViewController(buttonsToWatchVC, animated: true)
////           }
////       }
//
//    private func navigateToButtonsToWatch(withCategory category: String) {
//    if let buttonsToWatchVC = storyboard?.instantiateViewController(withIdentifier: "ButtonsToWatchViewController") as? ButtonsToWatchViewController {
//        buttonsToWatchVC.selectedCategory = category
//        navigationController?.pushViewController(buttonsToWatchVC, animated: true)
//    } else {
//        print("Failed to instantiate ButtonsToWatchViewController from storyboard.")
//        }}
//
//}

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

