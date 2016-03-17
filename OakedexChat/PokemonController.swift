//
//  PokemonController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class PokemonController: NSObject {
    
    static let kBaseURL = "http://pokeapi.co/api/v2/pokemon/"
    
    static func getPokemon(searchTerm: String, completion: (pokemon: Pokemon?) -> Void) {
        let pokeSearchURL = kBaseURL + searchTerm.lowercaseString
        let url = NSURL(string: pokeSearchURL)
        NetworkController.dataAtURL(url!) { (data) -> Void in
            guard let data = data else {
                print("\(__FUNCTION__) - didn't return data bro)")
                completion(pokemon: nil)
                return
            }
            do {
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                if let dictionary = jsonObject as? [String: AnyObject] {
                    let pokemon = Pokemon(jsonDictionary: dictionary)
                    completion(pokemon: pokemon)
                } else {
                    completion(pokemon: nil)
                }
            } catch {
                print("\(__FUNCTION__) threw some erros dude")
                completion(pokemon: nil)
            }
        }
    }
}
