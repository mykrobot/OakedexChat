//
//  PokedexResultViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/17/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class PokedexResultViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
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
        self.view.layer.shouldRasterize = true
        
        pokeBallActivityImage.hidden = true
        viewBackImage.image = UIImage(named: "oakLab")
        
        pokemonNameLabel.layer.cornerRadius = 8
        pokemonNameLabel.clipsToBounds = true
        
        pokemonIDLabel.layer.cornerRadius = 8
        pokemonIDLabel.clipsToBounds = true
        pokemonIDLabel.hidden = true
        pokemonIDLabel.layer.borderColor = UIColor.blackColor().CGColor
        pokemonIDLabel.layer.borderWidth = 2
        
        PokemonExperienceLabel.layer.cornerRadius = 8
        PokemonExperienceLabel.clipsToBounds = true
        PokemonExperienceLabel.hidden = true
        PokemonExperienceLabel.layer.borderColor = UIColor.blackColor().CGColor
        PokemonExperienceLabel.layer.borderWidth = 2
        
        pokemonHeightLabel.layer.cornerRadius = 8
        pokemonHeightLabel.clipsToBounds = true
        pokemonHeightLabel.hidden = true
        pokemonHeightLabel.layer.borderColor = UIColor.blackColor().CGColor
        pokemonHeightLabel.layer.borderWidth = 2
        
        pokemonWeightLabel.layer.cornerRadius = 8
        pokemonWeightLabel.clipsToBounds = true
        pokemonWeightLabel.hidden = true
        pokemonHeightLabel.layer.borderColor = UIColor.blackColor().CGColor
        pokemonWeightLabel.layer.borderWidth = 2
        
        movesButton.layer.cornerRadius = 8
        movesButton.clipsToBounds = true
        movesButton.hidden = true
        movesButton.layer.borderColor = UIColor.blackColor().CGColor
        movesButton.layer.borderWidth = 2
        
        statsButton.layer.cornerRadius = 8
        statsButton.clipsToBounds = true
        statsButton.hidden = true
        statsButton.layer.borderColor = UIColor.blackColor().CGColor
        statsButton.layer.borderWidth = 2
        
        typeLabel.layer.cornerRadius = 8
        typeLabel.clipsToBounds = true
        typeLabel.hidden = true
        typeLabel.layer.borderColor = UIColor.blackColor().CGColor
        typeLabel.layer.borderWidth = 2
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let searchTerm = searchTerm {
            nameThatPokemon(searchTerm)
        }
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
    
    @IBAction func movesButtonTapped(sender: UIButton) {
        self.performSegueWithIdentifier("toMovesPopoverSegue", sender: self)
    }
    
    @IBAction func statsButtonTapped(sender: UIButton) {
        self.performSegueWithIdentifier("toStatsPopoverSegue", sender: self)
    }
    
    func nameThatPokemon(searchTerm: String) {
        rotateBro()
        pokeBallActivityImage.hidden = false
        
        PokemonController.getPokemon(searchTerm) { (pokemon) -> Void in
            guard let pokeResult = pokemon else { return }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.pokemonIDLabel.hidden = false
                self.PokemonExperienceLabel.hidden = false
                self.pokemonHeightLabel.hidden = false
                self.pokemonWeightLabel.hidden = false
                self.typeLabel.hidden = false
                self.movesButton.hidden = false
                self.statsButton.hidden = false
                
                self.pokeBallActivityImage.hidden = true
                
                self.pokemonNameLabel.text = pokeResult.name.capitalizedString
                self.pokemonIDLabel.text = "  ID: \(pokeResult.id)"
                self.PokemonExperienceLabel.text = "  Exp: \(pokeResult.baseExp)"
                self.pokemonHeightLabel.text = "  Height: \(pokeResult.height)"
                self.pokemonWeightLabel.text = "  Weight: \(pokeResult.weight)"
                self.pokemonImageView.image = UIImage(named: "\(pokeResult.id)")
                self.typeLabel.text = "  Type: \(pokeResult.types.joinWithSeparator(", "))"
                
                self.moves = "\(pokeResult.moves.joinWithSeparator(", "))"
                let statName = pokeResult.stats
                let baseStat = pokeResult.baseStats
                let statString = "\(statName[0]): \(baseStat[0])\n\(statName[1]): \(baseStat[1])\n\(statName[2]): \(baseStat[2])\n\(statName[3]): \(baseStat[3])\n\(statName[4]): \(baseStat[4])\n\(statName[5]): \(baseStat[5])\n"
                self.stats = statString
//                self.stats = "Stats: \n\(pokeResult.stats.joinWithSeparator("\n"))"
//                self.baseStats = "Base Stats: \n\(pokeResult.baseStats.joinWithSeparator("\n"))"
                
                self.viewBackImage.image = UIImage(named: "back\(arc4random_uniform(4)+1)")
            })
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMovesPopoverSegue" {
            let popoverVC = segue.destinationViewController as! PopoverViewController
            let controller = popoverVC.popoverPresentationController
            if let controller = controller {
                controller.delegate = self
                if let moves = moves {
                    popoverVC.strings = moves
                }
            }
        }
        else if segue.identifier == "toStatsPopoverSegue" {
            let popoverVC = segue.destinationViewController as! PopoverViewController
            let controller = popoverVC.popoverPresentationController
            if let controller = controller {
                controller.delegate = self
                if let stats = stats {
                    popoverVC.strings = stats
                }
            }
        }
    }
}

































