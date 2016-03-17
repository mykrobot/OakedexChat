//
//  Pokemon.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

struct Pokemon {
    
    let name: String
    let id: Int
    let baseExp: Int
    let height: Int
    let weight: Int
    var types: [String]
    var moves: [String]
    var stats: [String]
    var baseStats: [String]
    
    init?(jsonDictionary: [String: AnyObject]){
        guard let name = jsonDictionary["name"] as? String else { return nil }
        self.name = name
        self.id = jsonDictionary["id"] as? Int ?? 0
        self.baseExp = jsonDictionary["base_experience"] as? Int ?? 0
        self.height = jsonDictionary["height"] as? Int ?? 0
        self.weight = jsonDictionary["weight"] as? Int ?? 0
        
        guard let typesArray = jsonDictionary["types"] as? [[String: AnyObject]] else { return nil }
        self.types = []
        for typeDictionary in typesArray {
            guard let almostDictionary = typeDictionary["type"] as?  [String: AnyObject] else { return nil }
            guard let type = almostDictionary["name"] as? String else { return nil }
            self.types.append(type)
        }
        
        guard let movesArray = jsonDictionary["moves"] as? [[String: AnyObject]] else { return nil }
        self.moves = []
        for moveDictionary in movesArray {
            guard let almostDictionary = moveDictionary["move"] as?  [String: AnyObject] else { return nil }
            guard let move = almostDictionary["name"] as? String else { return nil }
            self.moves.append(move)
        }
        
        guard let statsArray = jsonDictionary["stats"] as? [[String: AnyObject]] else { return nil }
        self.stats = []
        for statDictionary in statsArray {
            guard let almostDictionary = statDictionary["stat"] as?  [String: AnyObject] else { return nil }
            guard let stat = almostDictionary["name"] as? String else { return nil }
            self.stats.append(stat)
        }
        
        guard let baseStatsArray = jsonDictionary["stats"] as? [[String: AnyObject]] else { return nil }
        self.baseStats = []
        for baseStatDictionary in baseStatsArray {
            let baseStat = baseStatDictionary["base_stat"] as? Int ?? 0
            self.baseStats.append("\(baseStat)")
        }
    }
}
