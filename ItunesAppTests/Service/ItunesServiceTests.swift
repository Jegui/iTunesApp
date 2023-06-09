//
//  ItunesAppTests.swift
//  ItunItunesServiceTestsesAppTests
//
//  Created by Juan Emilio Eguizabal on 08/06/2023.
//

import XCTest
@testable import ItunesApp

final class DelegateSpy: ItunesServiceDelegate {
    
    var itemsArrivedClosure: ((Array<ItunesItemResponse>) -> Void)?
    var itemsFailedToArriveClosure: ((CustomError?) -> Void)?
    
    
    func itemsArrived(items: Array<ItunesItemResponse>) {
        itemsArrivedClosure?(items)
    }
    
    func itemsFailedToArrive(_ error: CustomError?) {
        itemsFailedToArriveClosure?(error)
    }
    
    
}

final class ItunesServiceTests: XCTestCase {

    var sut: ItunesServiceType!
    let delegateSpy = DelegateSpy()
    
    override func setUpWithError() throws {
       try super.setUpWithError()
        sut = ItunesService(url: "https://itunes.apple.com/search?term=thebeatles&media=music&entity=album&attribute=artistTerm")
        sut.delegate = delegateSpy
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testServiceWithInternet() {
        // Given
        //itunes URL
        let expectation = XCTestExpectation(description: "Items arrive expectation.")
        delegateSpy.itemsArrivedClosure = { (items) in
            expectation.fulfill()
        }
        // When
        sut.getItems()
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
