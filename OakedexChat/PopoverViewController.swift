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
        self.view.layer.shouldRasterize = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.preferredContentSize = CGSize(width: 200, height: 200)
        popoverTextView.layer.cornerRadius = 8
        popoverTextView.clipsToBounds = true
        popoverTextView.contentOffset.y = 0.0
        popoverTextView.text = "\(strings ?? "")"
    }
}
