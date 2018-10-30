//
//  Character.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public struct Character: Decodable {
    public let id: Int
    public let name: String?
    public let description: String?
    public let thumbnail: Thumbnail?
    public let urls: [Urls]?
    
    public init(id: Int = 0,
                name: String? = nil,
                description: String? = nil,
                thumbnail: Thumbnail? = nil,
                urls: [Urls]? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.urls = urls
    }
}
