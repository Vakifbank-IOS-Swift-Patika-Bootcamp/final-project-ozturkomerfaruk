//
//  ViewController.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import UIKit

class GameListVC: UIViewController {
    
    private var viewModel = GameListViewModel()
    
    @IBOutlet weak var gameListTableView: UITableView! {
            didSet {
                gameListTableView.delegate = self
                gameListTableView.dataSource = self
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchGameList()
        viewModel.delegate = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getGame(at: indexPath.row)?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
    }
}
