//
//  QueryEncoder.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public enum QueryEncoder {
    static func encodeQuery<T: Encodable>(_ encodable: T) throws -> String {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParam].self, from: parametersData)
        return parameters
            .map({ "\($0)=\($1)" })
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
