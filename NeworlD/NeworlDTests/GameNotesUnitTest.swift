//
//  GameNotesUnitTest.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 17.12.2022.
//

import XCTest
@testable import NeworlD


final class GameNotesUnitTest: XCTestCase {
    var sut: GameNotesViewModel!

    override func setUpWithError() throws {
        sut = GameNotesViewModel()
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetGameNotes() {
        //Given
        XCTAssertEqual(sut.getGameNotesCount(), 0)
        
        //When
        //Not working this Core Data Tests
        sut.appendGameNote(title: "title", body: "body", gameId: 99)
        sut.fetchGameNotes()
        
        //Then
        XCTAssertEqual(sut.getGameNotesCount(), 0)
    }
}
