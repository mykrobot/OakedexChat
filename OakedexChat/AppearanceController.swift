//
//  AppearanceController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/17/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.

import UIKit

public class AppearanceController {
    
    static func initializeAppearances() {
        // MARK: - Status Bar
        UIApplication.sharedApplication().statusBarStyle = .LightContent // changes the battery and carrier color
        
        //MARK: - UINavigationBar
        UINavigationBar.appearance().barTintColor = .pokeBlack() // The solid color of the nav bar.
        UINavigationBar.appearance().backgroundColor = .pokeBlack() // slight shading under the nav bar.
        UINavigationBar.appearance().tintColor = .whiteColor() // will affect the color of bar button items on nav bar.
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()] // will affect the color of title
        
        // MARK: - UITabBar
        UITabBar.appearance().barTintColor = .pokeBlack() // solid color of the tab bar
        UITabBar.appearance().tintColor = .whiteColor() // color of the icons on the tab bar
        
        // MARK: - Table View
        UITableView.appearance().backgroundColor = .blackColor() // The solid color of the background under the cells
        
        // MARK: Table View Cell
        UITableViewCell.appearance().backgroundColor = .blackColor() // solid color background for cell
        //        UITableViewCell.appearance().selectionStyle = .None // doesn't quite doing anything that I am aware of...
        //        UITableViewCell.appearance().textLabel?.tintColor = <#UIColor#> // yeah, nothing much here...
        UITableViewCell.appearance().layer.borderColor = UIColor.ashHatRed().CGColor
        // MARK: - SearchBar
        //        UISearchBar.appearance().barTintColor = <#UIColor#>
        //        UISearchBar.appearance().tintColor = <#UIColor#>
        
        // MARK: - UILabel
        UILabel.appearance().textColor = .whiteColor() // changes text color in labels
    }
}


extension UITabBarController {
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension UINavigationController {
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

