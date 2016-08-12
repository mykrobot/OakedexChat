//
//  PokedexResultViewController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/17/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

class PokedexResultViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak private var pokemonNameLabel: UILabel!
    @IBOutlet weak private var pokemonIDLabel: UILabel!
    @IBOutlet weak private var PokemonExperienceLabel: UILabel!
    @IBOutlet weak private var pokemonHeightLabel: UILabel!
    @IBOutlet weak private var pokemonWeightLabel: UILabel!
    @IBOutlet weak private var pokemonImageView: UIImageView!
    @IBOutlet weak private var pokeSearchBar: UISearchBar!
    @IBOutlet weak private var pokeBallActivityImage: UIImageView!
    @IBOutlet weak private var viewBackImage: UIImageView!
    @IBOutlet weak private var typeLabel: UILabel!
    @IBOutlet weak private var movesButton: UIButton!
    @IBOutlet weak private var statsButton: UIButton!
    
    private var pokemon: Pokemon?
    private var moves: String?
    private var stats: String?
    private var baseStats:  String?
    var searchTerm: String?
    private let boundRect = CGRectMake(0, 0, 1, 1)
    
    //MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeBallActivityImage.hidden = true
        viewBackImage.image = UIImage(named: "oakLab")
        setupViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let searchTerm = searchTerm {
            nameThatPokemon(searchTerm)
        }
    }
    
    // MARK: - Configure Views
    private func setupViews() {
        pokemonNameLabel.layer.cornerRadius = 8
        pokemonNameLabel.clipsToBounds = true
        let labels: [UILabel] = [pokemonIDLabel,pokemonWeightLabel,pokemonHeightLabel,PokemonExperienceLabel,typeLabel]
        let buttons: [UIButton] = [movesButton,statsButton]
        configureLabels(labels)
        configureButtons(buttons)
    }
    
    private func configureLabels(labels: [UILabel]) {
        for label in labels {
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            label.hidden = true
            label.layer.borderColor = UIColor.blackColor().CGColor
            label.layer.borderWidth = 2
        }
    }
    
    private func configureButtons(buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.hidden = true
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.layer.borderWidth = 2
        }
    }
    
    // MARK: - Animation
    
    private func rotateBro() {
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
    
    private func nameThatPokemon(searchTerm: String) {
        rotateBro()
        pokeBallActivityImage.hidden = false
        PokemonController.getPokemon(searchTerm) { (pokemon) -> Void in
            guard let pokeResult = pokemon else { return }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.unhideLabels()
                self.setLabelText(pokeResult)
                self.setButtonText(pokeResult)
                self.viewBackImage.image = UIImage(named: "back\(arc4random_uniform(4)+1)")
            })
        }
    }
    
    private func unhideLabels() {
        self.pokemonIDLabel.hidden = false
        self.PokemonExperienceLabel.hidden = false
        self.pokemonHeightLabel.hidden = false
        self.pokemonWeightLabel.hidden = false
        self.typeLabel.hidden = false
        self.movesButton.hidden = false
        self.statsButton.hidden = false
        self.pokeBallActivityImage.hidden = true
    }
    
    private func setLabelText(pokeResult: Pokemon) {
        self.pokemonNameLabel.text = pokeResult.name.capitalizedString
        self.pokemonIDLabel.text = "  ID: \(pokeResult.id)"
        self.PokemonExperienceLabel.text = "  Exp: \(pokeResult.baseExp)"
        self.pokemonHeightLabel.text = "  Height: \(pokeResult.height)"
        self.pokemonWeightLabel.text = "  Weight: \(pokeResult.weight)"
        self.pokemonImageView.image = UIImage(named: "\(pokeResult.id)")
        self.typeLabel.text = "  Type: \(pokeResult.types.joinWithSeparator(", "))"
    }
    
    private func setButtonText(pokeResult: Pokemon) {
        self.moves = "\(pokeResult.moves.joinWithSeparator(", "))"
        let statName = pokeResult.stats
        let baseStat = pokeResult.baseStats
        let statString = "\(statName[0]): \(baseStat[0])\n\(statName[1]): \(baseStat[1])\n\(statName[2]): \(baseStat[2])\n\(statName[3]): \(baseStat[3])\n\(statName[4]): \(baseStat[4])\n\(statName[5]): \(baseStat[5])\n"
        self.stats = statString
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let popoverVC = segue.destinationViewController as? PopoverViewController
        let controller = popoverVC?.popoverPresentationController
        if segue.identifier == "toMovesPopoverSegue", let controller = controller, moves = moves {
                controller.delegate = self
                popoverVC?.strings = moves
        } else if segue.identifier == "toStatsPopoverSegue", let controller = controller, stats = stats {
                controller.delegate = self
                popoverVC?.strings = stats
        }
    }
}

































