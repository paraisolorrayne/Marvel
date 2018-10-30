//
//  Thumbnail.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

public struct Thumbnail: Decodable {
    public let url: URL
    
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        guard let url = URL(string: "\(path).\(fileExtension)") else { throw APIError.decodingError }
        self.url = url
    }
}
