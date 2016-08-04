//
//  TermsAndConditionsViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 4/8/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    // MARK: - Action Buttons    
    @IBAction func agreementButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
