//
//  DataContainer.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public struct DataContainer<Results: Decodable>: Decodable {
    public let results: Results
    
    public init(offset: Int = 0,
                limit: Int = 0,
                total: Int = 0,
                count: Int = 0,
                results: Results) {
        self.results = results
    }
}
