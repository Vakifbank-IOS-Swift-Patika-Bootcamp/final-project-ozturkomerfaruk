//
//  ViewController.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import UIKit

class GameListVC: UIViewController {
    
    private var viewModel = GameListViewModel()
    @IBOutlet weak var gameListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.delegate = self
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = .white
        
        //MARK: SearchController
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Search game by name"
        navigationItem.searchController = search
        
        title = "Game List"
        sortDeclaration()
    }
    
    private func configureTableView() {
        gameListTableView.delegate = self
        gameListTableView.dataSource = self
        viewModel.fetchGameList()
        gameListTableView.register(UINib(nibName: "GameCustomCell", bundle: nil), forCellReuseIdentifier: "gameCustomCell")
        
    }
}

extension GameListVC {
    func sortDeclaration() {
        let sortAtoZ = UIAction(title: "Sort By Name A - Z") { [weak self] action in
            guard let self = self else { return }
            self.viewModel.sortedAtoZ()
        }
        let sortZtoA = UIAction(title: "Sort By Name Z - A") { [weak self] action in
            guard let self = self else { return }
            self.viewModel.sortedZtoA()
        }
        let sortNewest = UIAction(title: "Sort By Newest Release Date") { [weak self] action in
            guard let self = self else { return }
            self.viewModel.fetchGameListOrderingNewest()
        }
        let sortOldest = UIAction(title: "Sort By Oldest Release Date") { [weak self] action in
            guard let self = self else { return }
            self.viewModel.fetchGameListOrderingOldest()
        }
        let sortHighest = UIAction(title: "Sort By Highest Rating") { [weak self] action in
            guard let self = self else { return }
            self.viewModel.fetchGameListOrderingHighest()
        }
        let sortLowest = UIAction(title: "Sort By Lowest Rating") { [weak self] action in
            guard let self = self else { return }
            self.viewModel.fetchGameListOrderingLowest()
        }
        let menu = UIMenu(title: "", children: [sortAtoZ, sortZtoA, sortNewest, sortOldest, sortHighest, sortLowest])
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(named: "filter"), primaryAction: nil, menu: menu)
    }
}

//MARK: SearchController with Endpoint
extension GameListVC: UISearchResultsUpdating {
    internal func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        let newString = text.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        viewModel.fetchGameListSearchByName(searchGameName: newString)
        gameListTableView.reloadData()
    }
}

extension GameListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGameListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCustomCell", for: indexPath) as? GameCustomCell,
              let model = viewModel.getGame(at: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(model: model)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "gameDetailVC") as? GameDetailVC else { return }
        vc.model = viewModel.getGame(at: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension GameListVC: GameListViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
    }
    
    //MARK: Alert Eklenecek
    func gamesFailed(error: Error) {
        print("ERRORRRRRR ALERT")
    }
}
