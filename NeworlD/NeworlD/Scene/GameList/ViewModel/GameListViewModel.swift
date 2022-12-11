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
    
    func sortedAtoZ()
    func sortedZtoA()
    func fetchGameListOrderingNewest()
    func fetchGameListOrderingOldest()
    func fetchGameListOrderingHighest()
    func fetchGameListOrderingLowest()
    func fetchGameListOrderingRecentlyAdded()
    func fetchGameListSearchByName(searchGameName: String)
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
    
    func sortedAtoZ() {
        let sortedGames = games!.sorted {
            $0.name < $1.name
        }
        self.games = sortedGames
        self.delegate?.gamesLoaded()
    }
    
    func sortedZtoA() {
        let sortedGames = games!.sorted {
            $0.name > $1.name
        }
        self.games = sortedGames
        self.delegate?.gamesLoaded()
    }
    
    func fetchGameListOrderingNewest() {
        Client.getGameListOrderingNewest(page: 1, pageSize: 50) { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.gamesFailed(error: error)
            }
            self.games = []
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func fetchGameListOrderingOldest() {
        Client.getGameListOrderingOldest(page: 1, pageSize: 50) { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.gamesFailed(error: error)
            }
            self.games = []
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func fetchGameListOrderingHighest() {
        Client.getGameListOrderingHighest(page: 1, pageSize: 50) { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.gamesFailed(error: error)
            }
            self.games = []
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func fetchGameListOrderingLowest() {
        Client.getGameListOrderingLowest(page: 1, pageSize: 50) { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.gamesFailed(error: error)
            }
            self.games = []
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func fetchGameListOrderingRecentlyAdded() {
        Client.getGameListOrderingRecentlyAdded(page: 1, pageSize: 50) { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.gamesFailed(error: error)
            }
            self.games = []
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func fetchGameListSearchByName(searchGameName: String) {
        Client.getGameListBySearch(searchGameName: searchGameName) { [weak self] games, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.gamesFailed(error: error)
            }
            self.games = games
        }
    }
}
