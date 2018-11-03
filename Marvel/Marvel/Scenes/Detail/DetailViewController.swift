//
//  DetailViewController.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

protocol DetailDisplayLogic: class {
    func displayCharacterDetail(viewModel: DetailModel.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic {

    // MARK: Propterties
    var interactor: DetailBusinessLogic?
    var router: DetailRouter?
    var imageCacheManager: ImageCacheManager = ImageCacheManager.shared
    private var detailUrl: URL!
    public var viewModel: DetailModel.ViewModel!
    let indicatorView = IndicatorView()

    // MARK: IBOutlets
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var characterDescription: UILabel!
    @IBOutlet var characterDetailButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!

    // MARK: Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        self.navigationItem.backBarButtonItem?.title = "Characters"
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupLook() {
        characterDetailButton.titleLabel?.font = FontUtils.getMarvelFont(withSize: 16)
        characterDescription.font = FontUtils.getMarvelFont(withSize: 18)
        characterDetailButton.layer.cornerRadius = 10
        characterDetailButton.layer.masksToBounds = true
    }

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLook()
        getCharacterDetails()
    }

    // MARK: Business Logic
    func getCharacterDetails() {
        indicatorView.show(in: self.view)
        if viewModel == nil {
            let request = DetailModel.Request()
            interactor?.getCharacter(request: request)
        } else {
            displayCharacterDetail(viewModel: self.viewModel)
        }
    }

    func displayCharacterDetail(viewModel: DetailModel.ViewModel) {
        indicatorView.hide(in: self.view)
        self.viewModel = viewModel
        imageCacheManager.getImage(imageUrl: self.viewModel.characterImageUrl!, completionHandler: { (image) in
            self.characterImageView.image = image
        })
        characterDescription.text = self.viewModel.characterDescription == "" ? "There is no description for this character" : String(encodedString: self.viewModel.characterDescription!)
        self.navigationItem.title = self.viewModel.characterName
        
        if self.viewModel.characterDetailUrl == nil {
            characterDetailButton.isHidden = true
        } else {
            detailUrl = self.viewModel.characterDetailUrl
        }
    }

    // MARK: IBAction
    @IBAction func showCharacterDetail(_ sender: Any) {
        router?.navigateToSafariViewController(url: detailUrl)
    }
}
