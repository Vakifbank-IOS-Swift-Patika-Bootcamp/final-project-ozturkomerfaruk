//
//  GameDetailViewModel.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 9.12.2022.
//

import Foundation

protocol GameDetailViewModelProtocol {
    var delegate: GameListViewModelDelegate? { get set }
    
    func fetchGameDetail(id: Int)
    func iCorouselImagesCount(model: GameModel) -> Int
    func iCorouselImagesArray(model: GameModel) -> [String]
    
    func getDescriptionRow() -> String
    func getPublisher() -> String
    
    func getRatingTableCount() -> Int
    func getRating(index: Int) -> RatingModel?
    
    func getWebsiteURLString() -> String?
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gamesLoaded()
    func gamesFailed(error: Error)
}

final class GameDetailViewModel {
    
    weak var delegate: GameDetailViewModelDelegate?
    private var viewModelGame: GameDetailModel?
    
    func fetchGameDetail(id: Int) {
        Client.getGameDetail(gameID: id) { [weak self] viewModelDetail, error in
            guard let self = self else { return }
            self.viewModelGame = viewModelDetail
            self.delegate?.gamesLoaded()
        }
    }
    
    func iCorouselImagesCount(model: GameModel) ->Int {
        var ssArray = [String]()
        
        for i in model.shortScreenshots {
            ssArray.append(i.image)
        }
        return ssArray.count
    }
    
    func iCorouselImagesArray(model: GameModel) -> [String] {
        var ssArray = [String]()
        
        for i in model.shortScreenshots {
            ssArray.append(i.image)
        }
        return ssArray
    }
    
    func getDescriptionRow() -> String {
        return viewModelGame?.descriptionRaw ?? "nil"
    }
    
    func getPublisher() -> String {
        return viewModelGame?.publishers.first?.name ?? "nil"
    }

    func getRatingTableCount() -> Int {
        return viewModelGame?.ratings.count ?? 0
    }
    
    func getRating(index: Int) -> RatingModel? {
        return viewModelGame?.ratings[index]
    }
    
    func getWebsiteURLString() -> String? {
        return viewModelGame?.website
    }
}

