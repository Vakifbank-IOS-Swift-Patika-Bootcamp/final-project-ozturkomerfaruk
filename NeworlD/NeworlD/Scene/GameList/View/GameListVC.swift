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
        viewModel.fetchGameList()
        viewModel.delegate = self
    }
    
    private func configureTableView() {
        gameListTableView.delegate = self
        gameListTableView.dataSource = self
        gameListTableView.register(UINib(nibName: "GameCustomCell", bundle: nil), forCellReuseIdentifier: "gameCustomCell")
        
    }
    
}

extension GameListVC: GameListViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
    }
    
    func gamesFailed(error: Error) {
        print("ERRORRRRRR ALERT")
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
        print("did select")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
