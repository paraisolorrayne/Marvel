//
//  HomeViewController.swift
//  Marvel
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation
import UIKit

typealias CharacterItem = HomeModel.ViewModel.CharacterItem

protocol HomeDisplayLogic: class {
    func displayFetchedCharacters(viewModel: HomeModel.ViewModel)
    func displayError()
}

enum PlaceholderState {
    case none
    case loading
    case error
}

class HomeViewController: UIViewController, HomeDisplayLogic {

    // MARK: Properties
    var interactor: HomeBusinessLogic?
    var router: HomeRouter?
    var imageCacheManager: ImageCacheManager = ImageCacheManager.shared
    var refreshControl = UIRefreshControl()
    private var arrayOfCharacters: [CharacterItem] = [CharacterItem]()

    // MARK: IBOutlet
    @IBOutlet var charactersTableView: UITableView!

    // MARK: Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if is3DTouchAvailable() {
            registerForPreviewing(with: self, sourceView: charactersTableView)
        }
        self.charactersTableView.estimatedRowHeight = 230.0
        self.charactersTableView.separatorStyle = .none
        setupRefreshControl()
        getCharacterList()
    }

    // MARK: Business Logic
    private func getCharacterList() {
        setPlaceholderView(.loading)
        interactor?.fetchCharacters(request: HomeModel.Request())
    }

    func displayFetchedCharacters(viewModel: HomeModel.ViewModel) {
        if let characters = viewModel.listOfCharacters {
            arrayOfCharacters.removeAll()
            arrayOfCharacters.append(contentsOf: characters)
            self.setPlaceholderView(.none)
            DispatchQueue.main.async {
                self.charactersTableView.reloadData()
                self.stopRefreshing()
            }
        }
    }

    func displayError() {
        setPlaceholderView(.error)
        stopRefreshing()
    }

    // MARK: UI
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = self.charactersTableView.contentOffset.y
        for cell in self.charactersTableView.visibleCells as! [HomeCharacterTableViewCell] {
            let x = cell.characterImage.frame.origin.x
            let w = cell.characterImage.bounds.width
            let h = cell.characterImage.bounds.height
            let y = ((offsetY - cell.frame.origin.y) / h) * 25
            cell.characterImage.frame = CGRect(x: x, y: y, width: w, height: h)
        }
    }

    func setPlaceholderView(_ state: PlaceholderState) {
        DispatchQueue.main.async {
            switch (state) {
            case .error:
                self.charactersTableView.backgroundView = HomeErrorPlaceholderView()
                break
            case .loading:
                self.charactersTableView.backgroundView = HomeLoadingPlaceholderView()
                break
            case .none:
                self.charactersTableView.backgroundView = nil
                break
            }
        }
    }
}

// MARK: TableView Methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return charactersTableView.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeCharacterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(HomeCharacterTableViewCell.self)") as! HomeCharacterTableViewCell
        let characterItem = self.arrayOfCharacters[indexPath.row] as CharacterItem
        cell.characterName.text = characterItem.name
        imageCacheManager.getImage(imageUrl: characterItem.thumbnailUrl!) { (image) in
            if let updateCell = tableView.cellForRow(at: indexPath) as? HomeCharacterTableViewCell {
                updateCell.characterImage.image = image
            }
        }
        
        return cell
    }
}

// MARK: Navigation
extension HomeViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

// MARK: UIViewControllerPreviewingDelegate
extension HomeViewController: UIViewControllerPreviewingDelegate {

    private func createDetailViewControllerIndexPath(indexPath: IndexPath) -> DetailViewController {
        let characterItem = arrayOfCharacters[indexPath.row]
        let viewModel = DetailModel.ViewModel(characterName: characterItem.name, characterImageUrl: characterItem.thumbnailUrl, characterDescription: characterItem.description, characterDetailUrl: characterItem.detailUrl)
        let detailViewController = UIStoryboard(name: "DetailScene", bundle: nil).instantiateInitialViewController() as! DetailViewController
        detailViewController.viewModel = viewModel
        return detailViewController
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = charactersTableView.indexPathForRow(at: location) else {
            return nil
        }
        
        let detailViewController = createDetailViewControllerIndexPath(indexPath: indexPath)
        return detailViewController
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        router?.navigateToDetailViewController(source: self, destination: viewControllerToCommit as! DetailViewController)
    }
}

// MARK: Setup
extension HomeViewController {

    private func setup() {
        self.title = "Characters"
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action:#selector(refreshCharacterData(_:)), for: UIControl.Event.valueChanged)
        charactersTableView.refreshControl = refreshControl
    }
}

// MARK: Refresh
extension HomeViewController {

    @objc private func refreshCharacterData(_ sender: Any) {
        self.arrayOfCharacters.removeAll()
        self.charactersTableView.reloadData()
        getCharacterList()
    }

    private func stopRefreshing() {
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
}
