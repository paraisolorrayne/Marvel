//
//  HomeRouter.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation
import UIKit

@objc protocol HomeRouterRoutingLogic {
    func routeToDetailScene(segue: UIStoryboardSegue)
}

protocol HomeRouterDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRouterRoutingLogic, HomeRouterDataPassing {
    
    weak var viewController: HomeViewController!
    var dataStore: HomeDataStore?
    
    func routeToDetailScene(segue: UIStoryboardSegue) {
        if let destinationVC = segue.destination as? DetailViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetailViewController(source: dataStore!, destination: &destinationDS)
        }
    }
    
    func navigateToDetailViewController(source: HomeViewController, destination: DetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func passDataToDetailViewController(source: HomeDataStore, destination: inout DetailDataStore) {
        let selectedRow = viewController?.charactersTableView.indexPathForSelectedRow?.row
        let characterItem = source.response?[selectedRow!]
        destination.character = HomeModel.ViewModel.CharacterItem(name: characterItem?.name, description: characterItem?.description, thumbnailUrl: characterItem?.thumbnail?.url, detailUrl: characterItem?.urls?.filter { $0.type == "detail" }.first?.url?.toURL())
    }
}
