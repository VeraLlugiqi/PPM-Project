//
//  ButtonsToWatchViewController.swift
//  Write
//
//  Created by O on 04/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit

var nameToWatchB = ["IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie"]
var categoryToWatchB = ["Movie","Series","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie",]
var descriptionToWatchB = ["bfjk sjkvbd dhbs dsbjbvs","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie",]
var myIndexThree = 0

class ButtonsToWatchViewController: UIViewController {
    
    @IBOutlet weak var TableButtons: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
extension ButtonsToWatchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameToWatchB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellTwo = TableButtons.dequeueReusableCell(withIdentifier: "cellThree", for:indexPath)
        
        cellTwo.textLabel?.text = nameToWatchB[indexPath.row]
        
        return cellTwo
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndexTwo = indexPath.row
        
        // Deselect the row with animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Perform the segue
        performSegue(withIdentifier: "homeThree", sender: self)
    }
    
    
    
    
}

