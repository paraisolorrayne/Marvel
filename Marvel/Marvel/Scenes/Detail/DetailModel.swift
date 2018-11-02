//
//  DetailModel.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

enum DetailModel {
    
    struct Request {
        
    }
    
    struct Response {
        var character: HomeModel.ViewModel.CharacterItem?
    }
    
    struct ViewModel {
        var characterName: String?
        var characterImageUrl: URL?
        var characterDescription: String?
        var characterDetailUrl: URL?
    }
}
