//
//  SortingOrder.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

enum SortingOrder: String {
    case FOC_DATE = "focDate"
    case ON_SALE_DATE = "onsaleDate"
    case TITLE = "title"
    case ISSUE_NUMBER = "issueNumber"
    case MODIFIED = "modified"
    
    case REVERSED_FOC_DATE = "-focDate"
    case REVERSED_ON_SALE_DATE = "-onsaleDate"
    case REVERSED_TITLE = "-title"
    case REVERSED_ISSUE_NUMBER = "-issueNumber"
    case REVERSED_MODIFIED = "-modified"
}
