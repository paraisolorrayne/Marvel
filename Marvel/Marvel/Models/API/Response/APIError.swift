//
//  APIError.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case encodingError
    case decodingError
    case serverError(message: String)
}
