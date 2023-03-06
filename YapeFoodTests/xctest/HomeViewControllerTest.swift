//
//  HomeViewControllerTest.swift
//  YapeFoodTests
//
//  Created by Marcelo Stefano Velasquez Herrera on 6/03/23.
//

import XCTest

final class HomeViewControllerTest: XCTestCase {
    
    var sut: HomeViewController?

    override func setUp() {
        sut = HomeViewController()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testNavigationController() {
        sut?.setupNavigationController()
    }

}
