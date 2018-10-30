//
//  AppConfig.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

class AppConfig {
    
    static func enforceAPIKeysAreSetUp() {
        if ApiKeys.getPublicKey().isEmpty && ApiKeys.getPrivateKey().isEmpty {
            fatalError("The Marvel API public and private keys are not set up. Please set MARVEL_PUBLIC_KEY & MARVEL_PUBLIC_KEY in apikeys.plist.")
        }
    }
}
