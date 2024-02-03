//
//  WatchedViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit
var nameWatched = ["IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie"]
var categoryWatched = ["Movie","Series","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie",]
var descriptionWatched = ["bfjk sjkvbd dhbs dsbjbvs","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie",]
var myIndexTwo = 0

class WatchedViewController: UIViewController {
    
    
    @IBOutlet weak var WatchedTable: UITableView!
    
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


extension WatchedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameWatched.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellTwo = WatchedTable.dequeueReusableCell(withIdentifier: "cellTwo", for:indexPath)
        
        cellTwo.textLabel?.text = nameWatched[indexPath.row]
        
        return cellTwo
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndexTwo = indexPath.row
        
        // Deselect the row with animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Perform the segue
        performSegue(withIdentifier: "homeTwo", sender: self)
    }
    
    
    
    
}
