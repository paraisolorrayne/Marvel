//
//  ViewController+Is3DTouchAvailable.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func is3DTouchAvailable() -> Bool {
        if #available(iOS 9, *) {
            return traitCollection.forceTouchCapability == .available
        }
        return false
    }
}
