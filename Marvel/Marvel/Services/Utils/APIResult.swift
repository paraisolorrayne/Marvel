//
//  APIResult.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public typealias APIResultCallback<Value> = (APIResult<Value>) -> Void

public enum APIResult<Value> {
    case success(Value)
    case failure(Error)
}
