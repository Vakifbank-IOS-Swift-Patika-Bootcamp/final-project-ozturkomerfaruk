//
//  ViewController.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import UIKit

class GameListVC: UIViewController {
    
    private var viewModel = GameListViewModel()
    private var filterView: FilterView?
    
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
    }
    
    private func configureTableView() {
        gameListTableView.delegate = self
        gameListTableView.dataSource = self
        viewModel.fetchGameList()
        gameListTableView.register(UINib(nibName: "GameCustomCell", bundle: nil), forCellReuseIdentifier: "gameCustomCell")
        
    }
    
    
    @IBAction func filterAction(_ sender: Any) {
        
        filterView = FilterView(frame: CGRect(origin: CGPointMake(view.center.x - 110, 150), size: CGSize(width: 300, height: 360)))
        filterView!.backgroundColor = .lightGray
        filterView!.delegate = self
        view.addSubview(filterView!)
        
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


extension GameListVC: FilterViewDelegate {
    
    func didTapped() {
        print("didTapped Function FilterViewDelegate")
    }
    
    func sortAtoZ() {
        viewModel.sortedAtoZ()
    }
    
    func sortZtoA() {
        viewModel.sortedZtoA()
    }
    
    func sortNewest() {
        viewModel.fetchGameListOrderingNewest()
    }
    
    func sortOldest() {
        viewModel.fetchGameListOrderingOldest()
    }
    
    func sortHighest() {
        viewModel.fetchGameListOrderingHighest()
    }
    
    func sortLowest() {
        viewModel.fetchGameListOrderingLowest()
    }
    
    func sortRecentlyAdded() {
        viewModel.fetchGameListOrderingRecentlyAdded()
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
