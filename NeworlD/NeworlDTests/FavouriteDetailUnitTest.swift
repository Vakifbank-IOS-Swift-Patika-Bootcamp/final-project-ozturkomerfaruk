//
//  FavouriteDetailUnitTest.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 17.12.2022.
//

import XCTest
@testable import NeworlD

final class FavouriteDetailUnitTest: XCTestCase {
    var viewModel: FavouriteDetailViewModel!
    var fetchExpectation: XCTestExpectation!

    //Given -> When -> Then
    override func setUpWithError() throws {
        viewModel = FavouriteDetailViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "favouriteDetail")
    }
    
    func testGetLblName() {
        XCTAssertNil(viewModel.getLblName())
        
        viewModel.fetchFavouriteGameDetail(gameId: 22509)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getLblName(), "Minecraft")
    }
    
    func testGetImgGame() {
        XCTAssertEqual(viewModel.getImgGame(), "https://thumbs.dreamstime.com/z/oops-sticky-note-yellow-pinned-red-push-pin-cork-board-92680037.jpg")
        
        viewModel.fetchFavouriteGameDetail(gameId: 22509)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getImgGame(), "https://media.rawg.io/media/games/b4e/b4e4c73d5aa4ec66bbf75375c4847a2b.jpg")
    }
    
    func testGetLblRelease() {
        XCTAssertNil(viewModel.getLblRelease())
        
        viewModel.fetchFavouriteGameDetail(gameId: 22509)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getLblRelease(), "Jan 05, 2009")
    }
    
    func testGetLblUserReviews() {
        XCTAssertEqual(viewModel.getLblUserReviews(), " | -1 User Reviews")
        
        viewModel.fetchFavouriteGameDetail(gameId: 22509)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getLblUserReviews(), "Exceptional | 1410 User Reviews")
    }
}

extension FavouriteDetailUnitTest: FavouriteDetailViewModelDelegate {
    func gameLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gameFailed(error: Error) {}
    func preFetch() {}
    
}
