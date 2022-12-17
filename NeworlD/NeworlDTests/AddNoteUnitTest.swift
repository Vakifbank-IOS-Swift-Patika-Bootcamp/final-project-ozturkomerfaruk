//
//  AddNoteUnitTest.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 17.12.2022.
//

import XCTest
@testable import NeworlD

final class AddNoteUnitTest: XCTestCase {
    var viewModel: AddNoteViewModel!
    var fetchExpectation: XCTestExpectation!

    //Given -> When -> Then
    override func setUpWithError() throws {
        viewModel = AddNoteViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "addNote")
    }
    
    func testGetGameWithId() {
        XCTAssertNil(viewModel.getGameWithId())
        
        viewModel.fetchGamesWithId(id: 3328)
        waitForExpectations(timeout: 10)
    

        XCTAssertEqual(viewModel.getGameWithId()?.id, 3328)
        XCTAssertEqual(viewModel.getGameWithId()?.name, "The Witcher 3: Wild Hunt")
        XCTAssertEqual(viewModel.getGameWithId()?.backgroundImage, "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg")
    }
}

extension AddNoteUnitTest: AddNoteViewModelDelegate {
    func gamesLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gamesFailed(error: Error) {}
    func preFetch() {}
    func postFetch() {}
}
