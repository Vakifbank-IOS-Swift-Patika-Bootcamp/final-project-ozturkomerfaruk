//
//  OnboardingUnitTest.swift
//  NeworlDTests
//
//  Created by Ömer Faruk Öztürk on 17.12.2022.
//

import XCTest
@testable import NeworlD

final class OnboardingUnitTest: XCTestCase {
    var viewModel: OnboardingViewModel!

    //Given -> When -> Then
    override func setUpWithError() throws {
        viewModel = OnboardingViewModel()
    }
    
    func testGetCountSlide() {
        XCTAssertEqual(viewModel.countSlide(), 0)
        
        viewModel.appendSlide(model: OnboardingModel(title: "title", description: "description", lottieViewStr: "lottieViewStr"))
        
        XCTAssertEqual(viewModel.countSlide(), 1)
    }
    
    func testGetSlideModel() {
        XCTAssertEqual(viewModel.countSlide(), 0)
        
        viewModel.appendSlide(model: OnboardingModel(title: "title", description: "description", lottieViewStr: "lottieViewStr"))
        
        XCTAssertEqual(viewModel.getSlideModel(at: 0).title, "title")
        XCTAssertEqual(viewModel.getSlideModel(at: 0).description, "description")
        XCTAssertEqual(viewModel.getSlideModel(at: 0).lottieViewStr, "lottieViewStr")
    }
}
