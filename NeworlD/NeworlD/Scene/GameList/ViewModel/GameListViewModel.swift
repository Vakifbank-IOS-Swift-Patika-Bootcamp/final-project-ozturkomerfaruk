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
    
    func preFetch()
    func postFetch()
    func preSearchText()
}

final class GameListViewModel: GameListViewModelProtocol {
    weak var delegate: GameListViewModelDelegate?
    private var games: [GameModel]?
    
    func fetchGameList() {
        delegate?.preFetch()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Client.getGameList(page: 1, pageSize: 50) { [weak self] games, error in
                guard let self = self else { return }
                self.games = games
                self.delegate?.gamesLoaded()
            }
            self.delegate?.postFetch()
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
        delegate?.preFetch()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Client.getGameListOrderingNewest(page: 1, pageSize: 50) { [weak self] games, error in
                guard let self = self else { return }
                if let error = error {
                    self.delegate?.gamesFailed(error: error)
                }
                self.games = []
                self.games = games
                self.delegate?.gamesLoaded()
            }
            self.delegate?.postFetch()
        }
    }
    
    func fetchGameListOrderingOldest() {
        delegate?.preFetch()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Client.getGameListOrderingOldest(page: 1, pageSize: 50) { [weak self] games, error in
                guard let self = self else { return }
                if let error = error {
                    self.delegate?.gamesFailed(error: error)
                }
                self.games = []
                self.games = games
                self.delegate?.gamesLoaded()
            }
            self.delegate?.postFetch()
        }
    }
    
    func fetchGameListOrderingHighest() {
        delegate?.preFetch()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Client.getGameListOrderingHighest(page: 1, pageSize: 50) { [weak self] games, error in
                guard let self = self else { return }
                if let error = error {
                    self.delegate?.gamesFailed(error: error)
                }
                self.games = []
                self.games = games
                self.delegate?.gamesLoaded()
            }
            self.delegate?.postFetch()
        }
    }
    
    func fetchGameListOrderingLowest() {
        delegate?.preFetch()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Client.getGameListOrderingLowest(page: 1, pageSize: 50) { [weak self] games, error in
                guard let self = self else { return }
                if let error = error {
                    self.delegate?.gamesFailed(error: error)
                }
                self.games = []
                self.games = games
                self.delegate?.gamesLoaded()
            }
            self.delegate?.postFetch()
        }
    }
    
    func fetchGameListOrderingRecentlyAdded() {
        delegate?.preFetch()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Client.getGameListOrderingRecentlyAdded(page: 1, pageSize: 50) { [weak self] games, error in
                guard let self = self else { return }
                if let error = error {
                    self.delegate?.gamesFailed(error: error)
                }
                self.games = []
                self.games = games
                self.delegate?.gamesLoaded()
            }
            self.delegate?.postFetch()
        }
    }
    
    func fetchGameListSearchByName(searchGameName: String) {
        if searchGameName.count == 0 {
            delegate?.postFetch()
        } else if searchGameName.count == 1 {
            delegate?.postFetch()
            delegate?.preSearchText()
        } else if searchGameName.count == 2 {
            delegate?.postFetch()
            delegate?.preSearchText()
        } else if searchGameName.count == 3 {
            delegate?.postFetch()
            delegate?.preSearchText()
        } else {
            delegate?.postFetch()
            Client.getGameListBySearch(searchGameName: searchGameName) { [weak self] games, error in
                guard let self = self else { return }
                if let error = error {
                    self.delegate?.gamesFailed(error: error)
                }
                self.games = games
                self.delegate?.gamesLoaded()
            }
            
        }
    }
}
