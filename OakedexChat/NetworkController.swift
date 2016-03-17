//
//  NetworkController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class NetworkController {
    
    static func dataAtURL(url: NSURL, completion: (data: NSData?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url) { (data, _, error) -> Void in
            if error != nil {
                print("Error in \(__FUNCTION__) - \(error!.localizedDescription)")
                completion(data: nil)
            } else {
                completion(data: data)
            }
        }
        dataTask.resume()
    }
}