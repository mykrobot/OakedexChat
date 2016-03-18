//
//  PopoverViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/17/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var popoverTextView: UITextView!
    
    var strings: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.preferredContentSize = CGSize(width: 200, height: 200)
        popoverTextView.layer.cornerRadius = 8
        popoverTextView.clipsToBounds = true
        popoverTextView.contentOffset.y = 0.0
        popoverTextView.text = "\(strings ?? "")"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
