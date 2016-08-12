//
//  AskOakTableViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/17/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class AskOakTableViewController: UITableViewController {

    @IBOutlet weak var searchTermTextField: UITextField!
    
    private var searchTerm: String?

    // MARK: - Action Buttons
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        if let text = searchTermTextField.text {
            if text.lowercaseString == "missingno" {
                self.performSegueWithIdentifier("MissingNoModallySegue", sender: self)
            } else {
                searchTerm = text
                self.performSegueWithIdentifier("searchySearch", sender: self)
                searchTermTextField.text = ""
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OakCell", forIndexPath: indexPath)
        cell.textLabel?.text = "Prof. Oak: Hey, \(UserController.sharedController.currentUser?.username ?? "")! Which pokemon would you like to hear about?"
        configureCellView(cell)
        return cell
    }
    
    private func configureCellView(cell: UITableViewCell) {
        cell.layer.cornerRadius = 8
        cell.contentView.layer.cornerRadius = 8
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "searchySearch" {
            let pokedexResultsVC = segue.destinationViewController as? PokedexResultViewController
            if let searchTerm = searchTerm {
                pokedexResultsVC?.searchTerm = searchTerm
            }
        }
    }
}










































