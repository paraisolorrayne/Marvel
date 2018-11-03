//
//  HomeLoadingPlaceholderView.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation
import UIKit

class HomeLoadingPlaceholderView: PlaceholderView {
    
    let label = UILabel()
    
    override func setupView() {
        super.setupView()
        
        label.text = "Fetching Marvel characters..."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(label)
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(activityIndicator)
        
        let views = ["label": label, "activity": activityIndicator]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-[activity]-[label]-|", options: [], metrics: nil, views: views)
        let vConstraintsLabel = NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: [], metrics: nil, views: views)
        let vConstraintsActivity = NSLayoutConstraint.constraints(withVisualFormat: "V:|[activity]|", options: [], metrics: nil, views: views)
        
        centerView.addConstraints(hConstraints)
        centerView.addConstraints(vConstraintsLabel)
        centerView.addConstraints(vConstraintsActivity)
    }
}
