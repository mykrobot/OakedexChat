//
//  ComposeSearchViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/9/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class ComposeSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var fightOChatButton: UIBarButtonItem!
    @IBOutlet weak var composeTableView: UITableView!
    var searchController: UISearchController!
    
    
    var thread: Thread?
    var selectedTrainers: [User] = []
    var selectedTrainersAsAString: [String] = []
    var userDataSource: [User] = []
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.layer.shouldRasterize = true
        
        self.navigationItem.title = "Select Trainers"
        fightOChatButton.enabled = false
        if let currentUser = UserController.sharedController.currentUser {
            selectedTrainers.append(currentUser)
            selectedTrainersAsAString.append(currentUser.username)
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Run"
        navigationItem.backBarButtonItem = backItem

        //setUpSearchController()
    }
    
    override func viewWillAppear(animated: Bool) {
        UserController.fetchAllUsers { (users) -> Void in
            dispatch_async(dispatch_get_main_queue(), { _ in
                self.composeTableView.reloadData()
            })
            self.userDataSource = users.filter({$0 != UserController.sharedController.currentUser})
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }

    
    
    // MARK: - Action Button
    
    @IBAction func fightChatButtonTapped(sender: AnyObject) {
        ThreadController.createThread("\(selectedTrainersAsAString.joinWithSeparator(", "))", users: selectedTrainers) { (thread) -> Void in
            if let thread = thread {
                self.thread = thread
                print(thread)
                self.performSegueWithIdentifier("composeToThread", sender: self)
            }
        }
        
        
        
        
        
    }
    
    
    // MARK: - TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("allUsersCell", forIndexPath: indexPath)
        let user = userDataSource[indexPath.row]
        cell.textLabel?.text = user.username

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = userDataSource[indexPath.row]
        selectedTrainers.append(user)
        fightOChatButton.enabled = true
        selectedTrainersAsAString.append(user.username)
        userDataSource.removeAtIndex(indexPath.row)
        composeTableView.reloadData()
        self.navigationItem.title = "\(selectedTrainersAsAString.joinWithSeparator(", "))"
        print("\(selectedTrainers)")
    }
    
    // MARK: - SearchResults Methods
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            let searchTerm = text.lowercaseString
            let filteredUsers = userDataSource.filter { $0.username.lowercaseString.containsString(searchTerm) }
            guard let resultsController = searchController.searchResultsController as? SearchResultsTableViewController else { return }
            resultsController.userResultsDataSource = filteredUsers
            resultsController.tableView.reloadData()
            

        }
    }
    
    func setUpSearchController() {
       let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SearchReultsTVC")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for users"
        
        
        composeTableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "composeToThread" {
            let messagesDetailTVC = segue.destinationViewController as! MessageDetailTableViewController
            if let thread = thread {
                messagesDetailTVC.thread = thread
            }
            
        }
    }
}






































