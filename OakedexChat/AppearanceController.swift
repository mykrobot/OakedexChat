//
//  AppearanceController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/17/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearances() {
        UINavigationBar.appearance().layer.shouldRasterize = true
        UILabel.appearance().layer.shouldRasterize = true
        UIBarButtonItem.appearance().customView?.layer.shouldRasterize = true
        UIView.appearance().layer.shouldRasterize = true
        
//        UITableViewCell.appearance().backgroundColor = UIColor(red: 84/255.0, green: 87/255.0, blue: 89/255.0, alpha: 1.0)
//        UITableViewCell.appearance().textLabel?.textColor = UIColor(red: 76/255.0, green: 166/255.0, blue: 160/255.0, alpha: 1.0)
//        UITableViewCell.appearance().textLabel?.tintColor = UIColor(red: 76/255.0, green: 166/255.0, blue: 160/255.0, alpha: 1.0)
//        UINavigationBar.appearance().barTintColor = UIColor(red: 84/255.0, green: 87/255.0, blue: 89/255.0, alpha: 1.0)
//        //UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red: 166/255.0, green: 155/255.0, blue: 135/255.0, alpha: 1.0)]
//        UINavigationBar.appearance().tintColor = UIColor(red: 166/255.0, green: 155/255.0, blue: 135/255.0, alpha: 1.0)
//        
//        UILabel.appearance().textColor = UIColor(red: 76/255.0, green: 166/255.0, blue: 160/255.0, alpha: 1.0)
//        
//        //UIView.appearance().tintColor = UIColor(red: 166/255.0, green: 155/255.0, blue: 135/255.0, alpha: 1.0)
//        UITableView.appearance().backgroundColor = UIColor(red: 166/255.0, green: 155/255.0, blue: 135/255.0, alpha: 1.0)
        
        UINavigationBar.appearance().tintColor = UIColor.pokeLightestGray()
        UINavigationBar.appearance().barTintColor = UIColor.pokeHeavyGray()
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        UITableView.appearance().backgroundView?.tintColor = UIColor.pokeHeavyGray()
        UITableView.appearance().backgroundColor = UIColor.pokeHeavyGray()
        
        //UITableViewCell.appearance().textLabel?.tintColor = UIColor.pokeBlack()
        UITableViewCell.appearance().backgroundColor = UIColor.pokeLighterGray()
        
        UILabel.appearance().textColor = UIColor.pokeBlack()
        
        UITextView.appearance().backgroundColor = UIColor.pokeLighterGray()
        
        UITabBar.appearance().barTintColor = UIColor.pokeBlack()
        UITabBar.appearance().tintColor = UIColor.ashHatRed()
        
        
        
        

        
        
        
        

    }
}

