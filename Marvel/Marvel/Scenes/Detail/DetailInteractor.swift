//
//  DetailInteractor.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

protocol DetailBusinessLogic {
    func getCharacter(request: DetailModel.Request)
}

protocol DetailDataStore {
    var character: HomeModel.ViewModel.CharacterItem! { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
    
    var presenter: DetailPresentationLogic?
    
    var character: HomeModel.ViewModel.CharacterItem!
    
    func getCharacter(request: DetailModel.Request) {
        let response = DetailModel.Response(character: character)
        presenter?.presentCharacterDetail(response: response)
    }
    
}
