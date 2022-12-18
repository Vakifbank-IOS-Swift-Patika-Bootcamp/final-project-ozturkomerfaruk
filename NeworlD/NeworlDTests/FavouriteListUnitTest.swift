//
//  FavouriteListUnitTest.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 17.12.2022.
//

import XCTest
@testable import NeworlD

final class FavouriteListUnitTest: XCTestCase {

    
    var sut: FavouriteListViewModel!
    
    //Given -> When -> Then
    override func setUpWithError() throws {
        sut = FavouriteListViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetGameListCount() throws {
    }
}
