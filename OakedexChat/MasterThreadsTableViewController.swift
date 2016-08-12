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
    
    var printCount = 0
    
    var threadsWithFellowTrainers: [Thread] = []
    var currentUser: User? {
        return UserController.sharedController.currentUser
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let currentUser = currentUser, identifier = currentUser.identifier {
            observeThreadsForIdentifier(identifier)
        } else {
            self.tableView.reloadData()
            self.navigationController?.performSegueWithIdentifier("loginSignupModallySegue", sender: self)
        }
    }
    
    private func configureView() {
        let backItem = UIBarButtonItem()
        backItem.title = "Run"
        navigationItem.backBarButtonItem = backItem
        self.tableView.sectionHeaderHeight = 50
    }
    
    private func observeThreadsForIdentifier(identifier: String) {
        ThreadController.observeThreadsForIdentifier(identifier, completion: { (thread) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.threadsWithFellowTrainers = thread
                UserController.sharedController.currentUser?.threadIDs = thread.flatMap({$0.identifier})
                self.tableView.reloadData() // success
                self.printCount += 1
                print(self.printCount)
            })
        })
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("profOakCell") as UITableViewCell?
        header?.textLabel?.text = " Prof. Oak"
        configureHeaderView(header)
        return header
    }
    
    private func configureHeaderView(header: UITableViewCell?) {
        header?.layer.cornerRadius = 8
        header?.contentView.layer.cornerRadius = 8
        header?.layer.borderColor = UIColor.ashHatRed().CGColor
        header?.layer.borderWidth = 2
        header?.layer.masksToBounds = true
        header?.textLabel?.textColor = .whiteColor()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threadsWithFellowTrainers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trainersThreadsCell", forIndexPath: indexPath)
        let thread = threadsWithFellowTrainers[indexPath.row]
        cell.textLabel?.text = thread.threadName
        configureCellView(cell)
        return cell
    }
    
    private func configureCellView(cell: UITableViewCell) {
        cell.layer.cornerRadius = 8
        cell.contentView.layer.cornerRadius = 8
        cell.layer.borderColor = UIColor.ashHatRed().CGColor
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
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
    
    // MARK: - Navigation
    
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
































