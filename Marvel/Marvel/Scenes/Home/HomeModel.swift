//
//  HomeModel.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation
import UIKit

enum HomeModel {
    
    struct Request {
        var numOfCharacters: Int = 25 // Default value
        var orderBy: SortingOrder = SortingOrder.REVERSED_MODIFIED // Default value
    }
    
    struct Response {
        var response: DataContainer<[Character]>?
        var isError: Bool = false
        var errorMessage: String?
    }
    
    struct ViewModel {
        struct CharacterItem {
            var name: String?
            var description: String?
            var thumbnailUrl: URL?
            var detailUrl: URL?
        }
        var listOfCharacters: [CharacterItem]?
    }
}
