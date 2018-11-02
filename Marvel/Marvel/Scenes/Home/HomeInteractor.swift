//
//  HomeInteractor.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic {
    func fetchCharacters(request: HomeModel.Request)
}

protocol HomeDataStore {
    var response: [Character]? { get }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var response: [Character]?
    
    var worker: HomeWorker!
    
    func fetchCharacters(request: HomeModel.Request) {
        worker = HomeWorker()
        worker.fetchCharactersFromAPI(count: request.numOfCharacters, orderBy: request.orderBy, requestManager: RequestManager()) { (data) in
            
            self.response = data?.results
            
            var modelResponse: HomeModel.Response
            
            if let data = data {
                modelResponse = HomeModel.Response(response: data, isError: false, errorMessage: nil)
            } else {
                modelResponse = HomeModel.Response(response: nil, isError: true, errorMessage: "Unable to fetch data from Marvel API")
            }
            
            self.presenter?.presentFetchResults(response: modelResponse)
        }
    }
    
}
