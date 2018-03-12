//
//  CoreAnimationTableViewController.swift
//  Interviewing
//
//  Created by Алексей on 30.11.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class CoreAnimationTableViewController: UITableViewController {

    let segueShowAnimation = "segueShowAnimation"
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: self.segueShowAnimation, sender: tableView.cellForRow(at: indexPath))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if let vc = segue.destination as? CoreAnimationViewController,
                let cellTap = sender as? UITableViewCell,
                    identifier == segueShowAnimation{
                if let cellIdentifier = cellTap.reuseIdentifier{
                    switch cellIdentifier{
                    case "cellBasicAnimation":
                        vc.action = .baseAnimation
                    case "cellKeyframeAnimation":
                        vc.action = .keyAnimation
                    case "cellTransition":
                        vc.action = .transition
                    case "cellAnimationGroup":
                        vc.action = .animationGroup
                    case "cellBlockAnimation":
                        vc.action = .block
                    case "cellAnimation":
                        vc.action = .animation
                    default:
                        return
                    }
                }
            }
        }
    }
 

}
