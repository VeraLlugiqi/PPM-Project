//
//  ToWatchViewController.swift
//  Write
//
//  Created by O on 03/02/2024.
//  Copyright © 2024 FIEK. All rights reserved.
//

import UIKit

var namesKos = ["IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie"]
var categorysKos = ["Movie","Series","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie",]
var descriptionsKos = ["bfjk sjkvbd dhbs dsbjbvs","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie","IT","Movie",]
var myIndex = 0


class ToWatchViewController: UIViewController {

    @IBOutlet weak var ToWatchTable: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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

extension ToWatchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesKos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ToWatchTable.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
    
        cell.textLabel?.text = namesKos[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        
        // Deselect the row with animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Perform the segue
        performSegue(withIdentifier: "home", sender: self)
    }
    
    
    
    
}


