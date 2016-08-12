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
        print(url!)
        PokemonNetworkController.dataAtURL(url!) { (data) -> Void in
            guard let data = data else {
                print("\(#function) - didn't return data bro)")
                completion(pokemon: nil)
                return
            }
            let responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) ?? ""
            print(responseDataString)
            do {
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if let dictionary = jsonObject as? [String: AnyObject] {
                    let pokemon = Pokemon(jsonDictionary: dictionary)
                    completion(pokemon: pokemon)
                } else {
                    completion(pokemon: nil)
                }
            } catch {
                print("\(#function) threw some erros dude")
                completion(pokemon: nil)
            }
        }
    }
}
