//
//  ApiKeys.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

class ApiKeys {
    
    private static func valueForAPIKey(named keyname: String) -> String {
        let filePath = Bundle.main.path(forResource: "apikeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyname) as! String
        return value
    }
    
    static func getPublicKey() -> String {
        return self.valueForAPIKey(named: "MARVEL_PUBLIC_KEY")
    }
    
    static func getPrivateKey() -> String {
        return self.valueForAPIKey(named: "MARVEL_PRIVATE_KEY")
    }
    
}
