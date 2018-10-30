//
//  GetCharacters.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public struct GetCharacters: APIRequest {
    public typealias Response = [Character]
    
    public var resourceName: String {
        return "characters"
    }
    
    public let limit: Int?
    public let orderBy: String?
    
    public init(limit: Int? = nil, orderBy: String? = nil) {
        self.limit = limit
        self.orderBy = orderBy
    }
}
