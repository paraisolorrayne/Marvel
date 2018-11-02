//
//  DetailPresenter.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

protocol DetailPresentationLogic {
    func presentCharacterDetail(response: DetailModel.Response)
}

class DetailPresenter: DetailPresentationLogic {
    
    weak var viewController: DetailDisplayLogic?
    
    func presentCharacterDetail(response: DetailModel.Response) {
        
        let characterDetailViewModel = DetailModel.ViewModel(characterName: response.character?.name, characterImageUrl: response.character?.thumbnailUrl, characterDescription: response.character?.description, characterDetailUrl: response.character?.detailUrl)
        
        viewController?.displayCharacterDetail(viewModel: characterDetailViewModel)
    }
}
