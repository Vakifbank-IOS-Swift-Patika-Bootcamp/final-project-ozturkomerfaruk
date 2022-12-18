//
//  FavouriteListUnitTest.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 17.12.2022.
//

import XCTest
@testable import NeworlD

final class FavouriteListUnitTest: XCTestCase {

    
    var viewModel: FavouriteListViewModel!
    var fetchExpectation: XCTestExpectation!
    
    //Given -> When -> Then
    override func setUpWithError() throws {
        viewModel = FavouriteListViewModel()
        fetchExpectation = expectation(description: "fetchGameList")
    }
    
    func testGetGameListCount() throws {
        XCTAssertNil(viewModel.getFavourites(index: 0))

        viewModel.appendFavourites(gameId: 999)
        waitForExpectations(timeout: 10)

        XCTAssertEqual(viewModel.getFavourites(index: 0).gameId, 999)
    }
}
