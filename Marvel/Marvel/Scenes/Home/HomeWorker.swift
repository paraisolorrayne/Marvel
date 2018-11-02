//
//  HomeWorker.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

class HomeWorker {
    func fetchCharactersFromAPI(count: Int? = nil, orderBy: SortingOrder? = nil, requestManager: RequestManagerProtocol, completion: @escaping (DataContainer<[Character]>?) -> Void) {
        
        if !NetworkUtils.isInternetConnectionAvailable() {
            completion(nil)
        }
        
        requestManager.fetchCharacters(count: count, orderBy: orderBy) { (data) in
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
}
