//
//  SearchResultsTableViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/9/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    var userResultsDataSource: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.shouldRasterize = true
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResultsDataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultsCell", forIndexPath: indexPath)
        let users = userResultsDataSource[indexPath.row]
        cell.textLabel?.text = users.username
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // let sender = tableView.cellForRowAtIndexPath(indexPath)
        
        /////////////////////// COME BACK AND ADD THIS PERSON TO THE MESSAGE CONTACT LIST //////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
}
