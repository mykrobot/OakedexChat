//
//  MasterThreadsTableViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class MasterThreadsTableViewController: UITableViewController {

    var threadsWithFellowTrainers: [Thread] = []
    //var threadsWithFellowTrainers: [String] = ["this", "is", "a", "mock", "data", "test", "placeholder", "for", "thread", "data"] // MOCK DATA
    var currentUser: User? {
        return UserController.sharedController.currentUser
    }

    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = "Run"
        navigationItem.backBarButtonItem = backItem
        self.tableView.sectionHeaderHeight = 50
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let currentUser = currentUser {
            if let identifier = currentUser.identifier {
                ThreadController.observeThreadsForIdentifier(identifier, completion: { (thread) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //self.tableView.reloadData() // success
                    })
                    self.threadsWithFellowTrainers = thread
                    self.tableView.reloadData() // success
                })
            }
        } else {
            self.tableView.reloadData()
            self.navigationController?.performSegueWithIdentifier("loginSignupModallySegue", sender: self)
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("profOakCell") as UITableViewCell?
        header?.textLabel?.text = " Prof. Oak"
        
        return header
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return threadsWithFellowTrainers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("trainersThreadsCell", forIndexPath: indexPath)
        let thread = threadsWithFellowTrainers[indexPath.row]
        //cell.textLabel?.text = thread // MOCK DATA
        cell.textLabel?.text = thread.threadName
        
        return cell
    }
    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
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
        if segue.identifier == "toConversationSegue" {
           let messageDetailTVC = segue.destinationViewController as? MessageDetailTableViewController
            if let cell = sender as? UITableViewCell, indexPath = tableView.indexPathForCell(cell) {
                let thread = threadsWithFellowTrainers[indexPath.row]
                messageDetailTVC?.thread = thread
            }
        }
    }
}
































