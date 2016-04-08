//
//  MasterThreadsTableViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//



//users can create an account using the same username as another user. Since Firebase does not authorize by username, or even check to see if the username is available.

//Fatal runtime crash when trying to signup using email that already has an account


import UIKit

class MasterThreadsTableViewController: UITableViewController {

    var threadsWithFellowTrainers: [Thread] = []
    var currentUser: User? {
        return UserController.sharedController.currentUser
    }

    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.shouldRasterize = true
        
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
                    UserController.sharedController.currentUser?.threadIDs = thread.flatMap({$0.identifier})
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
        header?.layer.cornerRadius = 8
        header?.contentView.layer.cornerRadius = 8
        header?.layer.borderColor = UIColor.blackColor().CGColor
        header?.layer.borderWidth = 2
        header?.layer.masksToBounds = true
        return header
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return threadsWithFellowTrainers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("trainersThreadsCell", forIndexPath: indexPath)
        let thread = threadsWithFellowTrainers[indexPath.row]
        cell.textLabel?.text = thread.threadName
        cell.layer.cornerRadius = 8
        cell.contentView.layer.cornerRadius = 8
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let thread = threadsWithFellowTrainers[indexPath.row]
            UserController.removeThreadFromUser(thread)
            threadsWithFellowTrainers.removeAtIndex(indexPath.row)            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    // MARK: - Action Buttons
    
    @IBAction func profOakButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("textOakSegue", sender: self)
    }
    
//    @IBAction func logoutButtonTapped(sender: AnyObject) {
//        UserController.logOutCurrent()
//        self.threadsWithFellowTrainers = []
//        self.tableView.reloadData()
//        
//        self.viewWillAppear(true)
//        
//        
//        print("Logout button tapped")
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toConversationSegue" {
           let messageDetailTVC = segue.destinationViewController as! MessageDetailTableViewController
            if let cell = sender as? UITableViewCell, indexPath = tableView.indexPathForCell(cell) {
                let thread = threadsWithFellowTrainers[indexPath.row]
                messageDetailTVC.thread = thread
            }
        }
    }
}
































