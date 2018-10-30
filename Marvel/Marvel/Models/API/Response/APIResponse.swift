//
//  APIResponse.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public struct APIResponse<Response: Decodable>: Decodable {
    public let status: String?
    public let message: String?
    public let data: DataContainer<Response>?
}
