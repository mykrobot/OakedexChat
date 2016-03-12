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
    
    enum ButtonMode {
        case Signup
        case Login
    }
    
    var mode: ButtonMode = .Login
    var user: User?
    
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Signup:
                guard let username = usernameTextField.text, email = emailTextField.text, password = passwordTextField.text else { return false }
                return !username.isEmpty && !email.isEmpty && !password.isEmpty
            case .Login:
                guard let email = emailTextField.text, password = passwordTextField.text else { return false }
                return !email.isEmpty && !password.isEmpty
            }
        }
    }
    
    
    
    
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
        mode = .Signup
        if fieldsAreValid {
            UserController.createUser(emailTextField.text ?? "", password: passwordTextField.text ?? "", username: usernameTextField.text ?? "", completion: { (success, user) -> Void in
                if success {
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                } else {
                    self.presentValidationAlertWithtitle("Signup Unsuccessful", message: "Please try again")
                    
                }
            })
        } else {
            self.presentValidationAlertWithtitle("Missing Account Info", message: "Please try again, making sure to fill out all fields.")
        }
        
        
        
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        mode = .Login
        if fieldsAreValid {
            UserController.authenticateUser(emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: { (success, user) -> Void in
                if success {
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.presentValidationAlertWithtitle("Login Unsuccessful", message: "Please try again")
                }
            })
        } else {
            self.presentValidationAlertWithtitle("Missing Login Info", message: "Make sure that your email and password fields are both filled in correctly.")
        }
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func presentValidationAlertWithtitle(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .Destructive, handler: nil)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
