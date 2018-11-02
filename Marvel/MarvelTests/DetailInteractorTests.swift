//
//  DetailInteractorTests.swift
//  MarvelTests
//
//  Created by Lorrayne Paraiso  on 02/11/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

@testable import Marvel
import XCTest

class DetailInteractorTests: XCTestCase {
    
    var interactor: DetailInteractor!
    
    override func setUp() {
        super.setUp()
        setupDetailInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupDetailInteractor(){
        interactor = DetailInteractor()
    }
    
    class DetailPresentationLogicSpy: DetailPresentationLogic {
        var presentCharacterDetail = false

        func presentCharacterDetail(response: DetailModel.Response) {
            presentCharacterDetail = true
        }
    }
    
    func testGetCharactersShouldAskPresenterToFormatResult() {
        // Given
        let detailPresentationLogicSpy = DetailPresentationLogicSpy()
        interactor.presenter = detailPresentationLogicSpy
        
        // When
        let request = DetailModel.Request()
        interactor.getCharacter(request: request)
        
        // Then
        XCTAssert(detailPresentationLogicSpy.presentCharacterDetail, "getCharacter() should ask presenter to get character")
    }
}

