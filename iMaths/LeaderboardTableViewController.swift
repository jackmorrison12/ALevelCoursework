//
//  LeaderboardTableViewController.swift
//  iMaths
//
//  Created by Jack Morrison on 08/01/2017.
//  Copyright © 2017 Jack Morrison. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    var scores = [120,130,160,250,15,45,25,70,100,5]
    var names = ["Josh","Jess","Ben","Sam","Sophie","Dan","Hashan","Harry","Livvy","Bob"]

    var name = userDefaults.string(forKey: "Name")
    var score = userDefaults.integer(forKey: "Score")
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        names += [name!]
        scores += [score]

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let nElements = scores.count
        
        score = userDefaults.integer(forKey: "Score")
        super.viewWillAppear(animated)
        let pos = names.index(of: name!)
        scores[pos!] = score
        
        for fixedIndex in 0..<nElements {
            for i in fixedIndex+1..<nElements {
                if scores[fixedIndex] < scores[i] {
                    let tmp = scores[fixedIndex]
                    scores[fixedIndex] = scores[i]
                    scores[i] = tmp
                    let tmp2 = names[fixedIndex]
                    names[fixedIndex] = names[i]
                    names[i] = tmp2
                }
            }
        }
        

        tableView.reloadData()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        cell.detailTextLabel?.text = String(scores[indexPath.row])
        
        return cell
    }
    

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
