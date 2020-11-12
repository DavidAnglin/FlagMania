//
//  CoordinatorTests.swift
//  FlagManiaTests
//
//  Created by David Anglin on 11/12/20.
//

@testable import FlagMania
import XCTest

class CoordinatorTests: XCTestCase {

    var sut: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        let navigationController = UINavigationController()
        sut = AppCoordinator(navigationController: navigationController)
    }
    
    func testCoordinator_whenInitialized_childCoordinatorsIsEmpty() {
        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }
    
    func testCoordinator_whenInitialized_navigationControllerInitted() {
        XCTAssertNotNil(sut.navigationController)
    }
    
    func testCoordinator_onStart_viewControllerInNavController() {
        sut.start()
        XCTAssertTrue(sut.navigationController.viewControllers.count == 1)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
