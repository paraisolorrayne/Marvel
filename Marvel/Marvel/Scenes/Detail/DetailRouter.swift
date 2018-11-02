//
//  DetailRouter.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

@objc protocol DetailRoutingLogic {

}

protocol DetailDataPassing {
    var dataStore: DetailDataStore? { get }
}

class DetailRouter: NSObject, DetailRoutingLogic, DetailDataPassing {

    weak var viewController: DetailViewController?
    var dataStore: DetailDataStore?
    
    func navigateToSafariViewController(url: URL) {
        let safarVC = SFSafariViewController(url: url)
        viewController?.present(safarVC, animated: true)
    }
}

