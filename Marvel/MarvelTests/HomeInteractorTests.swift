//
//  HomeInteractorTests.swift
//  MarvelTests
//
//  Created by Lorrayne Paraiso  on 02/11/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

@testable import Marvel
import XCTest

class HomeInteractorTests: XCTestCase{
    
    var interactor: HomeInteractor!
    
    override func setUp() {
        super.setUp()
        setupHomeInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupHomeInteractor(){
        interactor = HomeInteractor()
    }
    
    class HomePresentationLogicSpy: HomePresentationLogic {
        
        var presentFetchedResultsCalled = false
        
        func presentFetchResults(response: HomeModel.Response) {
            presentFetchedResultsCalled = true
        }
    }
    
    func testGetCharactersShouldAskPresenterToFormatResult() {
        // Given
        let homePresentationLogicSpy = HomePresentationLogicSpy()
        interactor.presenter = homePresentationLogicSpy
        interactor.response = nil
        
        // When
        let request = HomeModel.Request()
        interactor.fetchCharacters(request: request)
        
        // Then
        XCTAssert(homePresentationLogicSpy.presentFetchedResultsCalled, "fetchCharacters() should ask presenter to format the characters")
    }
}
