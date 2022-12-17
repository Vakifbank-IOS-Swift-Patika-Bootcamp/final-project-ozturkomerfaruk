//
//  GameDetailUnitTest.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 17.12.2022.
//

import XCTest
@testable import NeworlD

final class GameDetailUnitTest: XCTestCase {
    var viewModel: GameDetailViewModel!
    var fetchExpectation: XCTestExpectation!

    //Given -> When -> Then
    override func setUpWithError() throws {
        viewModel = GameDetailViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "fetchGameDetail")
    }
    
    func testGetGameDetailDescriptionRow() throws {
        XCTAssertEqual(viewModel.getDescriptionRow(), "")

        viewModel.fetchGameDetail(id: 3328)
        waitForExpectations(timeout: 10)

        XCTAssertEqual(viewModel.getDescriptionRow(), "The third game in a series, it holds nothing back from the player. Open world adventures of the renowned monster slayer Geralt of Rivia are now even on a larger scale. Following the source material more accurately, this time Geralt is trying to find the child of the prophecy, Ciri while making a quick coin from various contracts on the side. Great attention to the world building above all creates an immersive story, where your decisions will shape the world around you.\n\nCD Project Red are infamous for the amount of work they put into their games, and it shows, because aside from classic third-person action RPG base game they provided 2 massive DLCs with unique questlines and 16 smaller DLCs, containing extra quests and items.\n\nPlayers praise the game for its atmosphere and a wide open world that finds the balance between fantasy elements and realistic and believable mechanics, and the game deserved numerous awards for every aspect of the game, from music to direction.")
    }
    
    func testGetPublisher() throws {
        XCTAssertEqual(viewModel.getPublisher(), "")
        
        viewModel.fetchGameDetail(id: 3328)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getPublisher(), "CD PROJEKT RED")
    }
    
    func testGetRatingTableCount() throws {
        XCTAssertEqual(viewModel.getRatingTableCount(), 0)
        
        viewModel.fetchGameDetail(id: 3328)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getRatingTableCount(), 4)
    }
    
    func testGetRating() throws {
        XCTAssertNil(viewModel.getRating(index: 0))
        
        viewModel.fetchGameDetail(id: 3328)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getRating(index: 0)?.id, 5)
        XCTAssertEqual(viewModel.getRating(index: 0)?.title, "exceptional")
        XCTAssertEqual(viewModel.getRating(index: 0)?.count, 4497)
        XCTAssertEqual(viewModel.getRating(index: 0)?.percent, 78.01)
    }
    
    func testGetWebsiteURLString() throws {
        XCTAssertNil(viewModel.getWebsiteURLString())
        
        viewModel.fetchGameDetail(id: 3328)
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getWebsiteURLString(), "https://thewitcher.com/en/witcher3")
        
    }
}

extension GameDetailUnitTest: GameDetailViewModelDelegate {
    func gamesLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gamesFailed(error: Error) {}
    func preFetch() {}
}
