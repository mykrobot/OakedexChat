//
//  MasterThreadsTableViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class MasterThreadsTableViewController: UITableViewController {

    var fellowTrainers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MessageController.observeMessagesForIdentifier(MessageController.sharedInstance.sender) { (_) -> Void in
//        }
//        MessageController.observeUsers() {users in
//            self.fellowTrainers = users.filter({$0 != MessageController.sharedInstance.sender})
//            self.tableView.reloadData()
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = UserController.sharedController.currentUser {
            self.tableView.reloadData()
            
        } else {
            self.navigationController?.performSegueWithIdentifier("loginSignupModallySegue", sender: self)
        }
    }
    
    
    
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("profOakCell")! as UITableViewCell
        header.textLabel?.text = " Prof. Oak"
        self.tableView.sectionHeaderHeight = 50
        return header
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fellowTrainers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("trainersThreadsCell", forIndexPath: indexPath)
        cell.textLabel?.text = fellowTrainers[indexPath.row]
        return cell
    }
    
    // MARK: - Action Buttons
    
    @IBAction func profOakButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("textOakSegue", sender: self)
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        UserController.logOutCurrent()
        self.viewWillAppear(true)
        print("Logout button tapped")
    }
    

    
    // po UserController.sharedController.currentUser
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Run"
        navigationItem.backBarButtonItem = backItem
//        if segue.identifier == "toConversationSegue" {
//            if let destination = segue.destinationViewController as? MessageDetailTableViewController {
//                if let indexPath = tableView.indexPathForSelectedRow {
//                    destination.recipient = self.fellowTrainers[indexPath.row]
//                }
//            }
//        }
    }
}



