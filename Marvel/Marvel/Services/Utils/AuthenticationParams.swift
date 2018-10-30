//
//  AuthenticationParams.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

class AuthenticationParams {
    
    public enum ParamType {
        case HASH
        case TIMESTAMP
        case PUBLIC_KEY
    }
    
    static func generateAuthParams() -> [ParamType : String] {
        let timeStamp = Date().toMillisString()
        let toHash: String = timeStamp + ApiKeys.getPrivateKey() + ApiKeys.getPublicKey()
        let md5Hash = toHash.MD5!
        
        var authDict = [ParamType : String]()
        authDict[ParamType.HASH] = md5Hash
        authDict[ParamType.TIMESTAMP] = timeStamp
        authDict[ParamType.PUBLIC_KEY] = ApiKeys.getPublicKey()
        
        return authDict
    }
    
}
