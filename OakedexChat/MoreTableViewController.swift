//
//  MoreTableViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 4/8/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {

    @IBOutlet weak var creditsCell: UITableViewCell!
    @IBOutlet weak var logoutCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditsCell.layer.cornerRadius = 8
        creditsCell.layer.borderColor = UIColor.blackColor().CGColor
        creditsCell.layer.borderWidth = 2
        creditsCell.layer.masksToBounds = true
        logoutCell.layer.cornerRadius = 8
        logoutCell.layer.borderColor = UIColor.blackColor().CGColor
        logoutCell.layer.borderWidth = 2
        logoutCell.layer.masksToBounds = true
    }

    // MARK: - Action Buttons
    
    @IBAction func logoutButtongTapped(sender: AnyObject) {
        UserController.logOutCurrent()
        tabBarController?.selectedIndex = 0
    }
}
