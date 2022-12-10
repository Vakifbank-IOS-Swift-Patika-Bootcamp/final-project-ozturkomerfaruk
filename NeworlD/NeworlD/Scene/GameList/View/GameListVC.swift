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
    }
    
    private func configureTableView() {
        gameListTableView.delegate = self
        gameListTableView.dataSource = self
        viewModel.fetchGameList()
        gameListTableView.register(UINib(nibName: "GameCustomCell", bundle: nil), forCellReuseIdentifier: "gameCustomCell")
        
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
    
    func gamesFailed(error: Error) {
        print("ERRORRRRRR ALERT")
    }
}
