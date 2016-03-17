//
//  PokedexResultViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/17/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class PokedexResultViewController: UIViewController {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var PokemonExperienceLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeBallActivityImage: UIImageView!
    @IBOutlet weak var viewBackImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var movesButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!

    var pokemon: Pokemon?
    var moves: String?
    var stats: String?
    var baseStats:  String?
    var searchTerm: String?
    static let sharedController = PokedexResultViewController()
    
    let boundRect = CGRectMake(0, 0, 1, 1)

    
    //MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Animation
    
    func rotateBro() {
        let rotateAnimate = CAKeyframeAnimation()
        rotateAnimate.keyPath = "position"
        rotateAnimate.path = CGPathCreateWithEllipseInRect(boundRect, nil)
        rotateAnimate.duration = 1.0
        rotateAnimate.speed = 2
        rotateAnimate.autoreverses = true
        rotateAnimate.additive = true
        rotateAnimate.repeatCount = Float.infinity
        rotateAnimate.calculationMode = kCAAnimationPaced
        rotateAnimate.rotationMode = kCAAnimationRotateAuto
        pokeBallActivityImage.layer.addAnimation(rotateAnimate, forKey: "rotate")
    }

    // MARK: - Action Buttons
    
    @IBAction func movesButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func statsButtonTapped(sender: AnyObject) {
        
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

































