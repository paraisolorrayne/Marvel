//
//  RequestManager.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

protocol RequestManagerProtocol {
    func fetchCharacters(count: Int?, orderBy: SortingOrder?, completion: @escaping (DataContainer<[Character]>?) -> Void)
}

class RequestManager: RequestManagerProtocol {
    
    private let apiClient: MarvelAPIClient = MarvelAPIClient()
    
    func fetchCharacters(count: Int? = nil, orderBy: SortingOrder? = nil, completion: @escaping (DataContainer<[Character]>?) -> Void) {
        apiClient.get(GetCharacters(limit: count, orderBy: orderBy?.rawValue)) { response in
            switch response {
            case .success(let dataContainer):
                completion(dataContainer)
            case .failure:
                completion(nil)
            }
        }
    }
}
