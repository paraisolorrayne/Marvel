//
//  APIRequest.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var resourceName: String { get }
}
