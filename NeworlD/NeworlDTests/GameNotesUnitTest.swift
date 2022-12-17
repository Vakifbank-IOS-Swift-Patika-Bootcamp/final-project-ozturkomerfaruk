//
//  GameNotesUnitTest.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 17.12.2022.
//

import XCTest
@testable import NeworlD


final class GameNotesUnitTest: XCTestCase {
    var viewModel: GameNotesViewModel!

    //Given -> When -> Then
    override func setUpWithError() throws {
        viewModel = GameNotesViewModel()
        viewModel.delegate = self
        
    }
    
}

extension GameNotesUnitTest: GameNotesViewModelDelegate {
    func notesLoaded() {
    }
    
    func notesFailed(error: Error) {}
    func preFetch() {
        
    }
    func postFetch() {}
}
