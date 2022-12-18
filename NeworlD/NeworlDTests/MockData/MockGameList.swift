//
//  MockGameList.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 18.12.2022.
//

import Foundation
@testable import NeworlD

final class MockGameListViewModel: GameListViewModelProtocol {
    
    private var gameModel = GameModel(id: 99, slug: "slug", name: "name", released: "released", backgroundImage: "backgroundImage", rating: 99.99, parentPlatforms: [ParentPlatformsBaseModel(platform: PlatformModel(id: 99, name: "PlatformName", slug: "PlatformSlug"))], genres: [GenresModel(id: 99, slug: "GenresSlug", name: "GenresName")], stores: [StoresBaseModel(id: 99, store: StoreModel(id: 99, name: "StoreName", slug: "StoreSlug", domain: "StoreDomain"))], tags: [TagsModel(id: 99, name: "TagsName", slug: "TagsSlug", language: "TagsLanguage", gamesCount: 99)], shortScreenshots: [ShortScreenshotsModel(id: 99, image: "shortScreenshotsImage")])
    
    private var gameModel2 = GameModel(id: 99, slug: "zzz", name: "zzz", released: "zzz", backgroundImage: "zzz", rating: 99.99, parentPlatforms: [ParentPlatformsBaseModel(platform: PlatformModel(id: 99, name: "zzz", slug: "zzz"))], genres: [GenresModel(id: 99, slug: "zzz", name: "zzz")], stores: [StoresBaseModel(id: 99, store: StoreModel(id: 99, name: "zzz", slug: "zzz", domain: "zzz"))], tags: [TagsModel(id: 99, name: "zzz", slug: "zzz", language: "zzz", gamesCount: 99)], shortScreenshots: [ShortScreenshotsModel(id: 99, image: "zzz")])
    
    private var gameModel3 = GameModel(id: 99, slug: "aaa", name: "aaa", released: "aaa", backgroundImage: "aaa", rating: 99.99, parentPlatforms: [ParentPlatformsBaseModel(platform: PlatformModel(id: 99, name: "aaa", slug: "aaa"))], genres: [GenresModel(id: 99, slug: "aaa", name: "aaa")], stores: [StoresBaseModel(id: 99, store: StoreModel(id: 99, name: "aaa", slug: "aaa", domain: "aaa"))], tags: [TagsModel(id: 99, name: "aaa", slug: "aaa", language: "aaa", gamesCount: 99)], shortScreenshots: [ShortScreenshotsModel(id: 99, image: "aaa")])
    
    var games: [GameModel]?
    
    var delegate: NeworlD.GameListViewModelDelegate?
    
    func fetchGameList() {
        games?.append(gameModel)
        games?.append(gameModel2)
        games?.append(gameModel3)
        print(games?.count)
    }
    
    func getGameListCount() -> Int {
        games?.count ?? 0
    }
    
    func getGame(at index: Int) -> NeworlD.GameModel? {
        games?[index]
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
        games?.append(gameModel)
        games?.append(gameModel2)
        games?.append(gameModel3)
    }
    
    func fetchGameListOrderingOldest() {
        games?.append(gameModel)
        games?.append(gameModel2)
        games?.append(gameModel3)
    }
    
    func fetchGameListOrderingHighest() {
        games?.append(gameModel)
        games?.append(gameModel2)
        games?.append(gameModel3)
    }
    
    func fetchGameListOrderingLowest() {
        games?.append(gameModel)
        games?.append(gameModel2)
        games?.append(gameModel3)
    }
    
    func fetchGameListOrderingRecentlyAdded() {
        games?.append(gameModel)
        games?.append(gameModel2)
        games?.append(gameModel3)
    }
    
    func fetchGameListSearchByName(searchGameName: String) {
        games?.append(gameModel)
        games?.append(gameModel2)
        games?.append(gameModel3)
    }
}
