//
//  FavouriteListViewModel.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 13.12.2022.
//

import Foundation

protocol FavouriteListProtocol {
    var delegate: FavouriteListDelegate? { get set }
    
    func getFavouritesCount() -> Int
    func fetchFavourites()
    func getFavourites(index: Int) -> FavouritesEntity
    func appendFavourites(gameId: Int)
    func deleteFavourites(index: Int)
    func isArrayEmpty() -> Bool
}

protocol FavouriteListDelegate: AnyObject {
    func favouritesLoaded()
    func favouritesFailed(error: Error)
    
    func preFetch()
    func postFetch()
    func preCollectionView()
}

final class FavouriteListViewModel: FavouriteListProtocol {
    weak var delegate: FavouriteListDelegate?
    private var favourites: [FavouritesEntity]?
    
    func getFavouritesCount() -> Int {
        return favourites?.count ?? 0
    }
    
    func fetchFavourites() {
        if favourites?.count == 0 {
            delegate?.preCollectionView()
        } else {
            delegate?.postFetch()
            favourites = CoreDataManager.shared.getFavourites()
            self.delegate?.favouritesLoaded()
        }
    }

    func getFavourites(index: Int) -> FavouritesEntity {
        return favourites![index]
    }
    
    func appendFavourites(gameId: Int) {
        favourites?.append(CoreDataManager.shared.saveFavourite(gameId: gameId)!)
        self.delegate?.favouritesLoaded()
    }
    
    func deleteFavourites(index: Int) {
        let fav = favourites![index]
        favourites?.remove(at: index)
        CoreDataManager.shared.deleteFavourite(favourite: fav)
        self.delegate?.favouritesLoaded()
    }
    
    func isArrayEmpty() -> Bool {
        return favourites?.count == 0 ? true : false
    }
}
