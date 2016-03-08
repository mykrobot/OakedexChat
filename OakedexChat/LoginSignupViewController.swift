//
//  LoginSignupViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/7/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    enum ViewMode {
        case Login
        case Signup
    }
    
    var user: User?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    // MARK: - Action Buttons
    
    @IBAction func signupButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
