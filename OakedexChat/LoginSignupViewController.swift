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
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var needAccountButton: UIButton!
    @IBOutlet weak var alreadyHaveButton: UIButton!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var tappyTap: UITapGestureRecognizer!
    
    enum ButtonMode {
        case Signup
        case Login
    }
    
    var mode: ButtonMode = .Login
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
        self.view.addGestureRecognizer(tappyTap)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        changeToLoginView()
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
    
    func presentValidationAlertWithtitle(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Destructive, handler: nil)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func tapGestureViewTapped(sender: UITapGestureRecognizer) {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func alreadyHaveAccountButtonTapped(sender: AnyObject) {
        changeToLoginView()
    }
    
    @IBAction func needAccountButtonTapped(sender: AnyObject) {
        changeToSignupView()
    }
    
    @IBAction func termsAndConditions(sender: AnyObject) {
        print("Terms!!!")
    }

    // MARK: - View Modes
    
    func changeToLoginView() {
        loginButton.hidden = false
        needAccountButton.hidden = false
        alreadyHaveButton.hidden = true
        takeOff()
        signupButton.hidden = true
    }
    
    func changeToSignupView() {
        signupButton.hidden = false
        needAccountButton.hidden = true
        alreadyHaveButton.hidden = false
        bringOn()
        loginButton.hidden = true
    }
    
    // MARK: - Animations
    
    func bringOn() {
        UIView.animateWithDuration(0.5, delay: 0.2, options: [], animations: {
            self.usernameTextField.alpha = 1
            self.signupButton.alpha = 1
            self.termsAndConditionsButton.alpha = 1
            self.loginButton.alpha = 0
            self.usernameTextField.alpha = 1
            }, completion: nil)
    }
    
    func takeOff() {
        UIView.animateWithDuration(0.5, delay: 0.2, options: [], animations: {
            self.usernameTextField.alpha = 0
            self.signupButton.alpha = 0
            self.termsAndConditionsButton.alpha = 0
            self.loginButton.alpha = 1
            }, completion: nil)
    }
}
