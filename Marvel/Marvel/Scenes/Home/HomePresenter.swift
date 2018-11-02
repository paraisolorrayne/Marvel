//
//  HomePresenter.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

protocol HomePresentationLogic {
    func presentFetchResults(response: HomeModel.Response)
}

class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic!
    
    func presentFetchResults(response: HomeModel.Response) {
        if response.isError {
            viewController.displayError()
        } else {
            var arrayOfCharacters = [HomeModel.ViewModel.CharacterItem]()
            
            for character in response.response!.results {
                arrayOfCharacters.append(HomeModel.ViewModel.CharacterItem(name: character.name, description: character.description, thumbnailUrl: character.thumbnail?.url, detailUrl: character.urls?.filter { $0.type == "detail" }.first?.url?.toURL()))
            }
            
            let characterViewModel = HomeModel.ViewModel(listOfCharacters: arrayOfCharacters)
            
            viewController.displayFetchedCharacters(viewModel: characterViewModel)
        }
    }
    
}
