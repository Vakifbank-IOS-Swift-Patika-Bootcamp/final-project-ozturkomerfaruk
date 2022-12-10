//
//  GameListViewModel.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import Foundation

protocol GameListViewModelProtocol {
    var delegate: GameListViewModelDelegate? { get set }
    
    func fetchGameList()
    func getGameListCount() -> Int
    func getGame(at index: Int) -> GameModel?
}

protocol GameListViewModelDelegate: AnyObject {
    func gamesLoaded()
    func gamesFailed(error: Error)
    
    // func preFetch()
    // func postFetch()
}

class GameListViewModel: GameListViewModelProtocol {
    weak var delegate: GameListViewModelDelegate?
    private var games: [GameModel]?
    
    func fetchGameList() {
        Client.getGameList(page: 1, pageSize: 50) { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.gamesFailed(error: error)
            }
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func getGameListCount() -> Int {
        return games?.count ?? 0
    }
    
    func getGame(at index: Int) -> GameModel? {
        return games?[index]
    }
    
    
}
