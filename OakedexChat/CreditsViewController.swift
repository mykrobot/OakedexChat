//
//  CreditsViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 4/8/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var creditTextView: UITextView!
    let creditString = "This app uses data and sprintes from the Pokémon series and video games. Some terminology from the Pokémon franchise is also used within the software itself. This is all intellectual property of Nintendo, Creatures, inc., and GAME FREAK, inc., and it is protected by various copyrights and trademarks. The author believes that the use of this intellectual property for a fan reference is covered by fair use and that the software is significantly impaired without said property included.\n\nImages from the Veekun database were used in this project (http://veekun.com)."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditTextView.layer.cornerRadius = 8
        creditTextView.layer.borderColor = UIColor.blackColor().CGColor
        creditTextView.layer.borderWidth = 2
        creditTextView.layer.masksToBounds = true
        creditTextView.text = "\(creditString)"
        
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
