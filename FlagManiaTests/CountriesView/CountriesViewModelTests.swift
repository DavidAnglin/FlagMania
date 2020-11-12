//
//  CountriesViewModelTests.swift
//  FlagManiaTests
//
//  Created by David Anglin on 11/12/20.
//

@testable import FlagMania
import XCTest

class CountriesViewModelTests: XCTestCase {

    var sut: CountriesListViewModel!
    
    override func setUp() {
        super.setUp()
        let apiClient = MockCountriesListService()
        sut = CountriesListViewModel(apiClient: apiClient)
    }
    
    func test_viewModel_title() {
        XCTAssertEqual(sut.getTitle(), "Country List")
    }
    
    func test_viewModel_fetchCountries() {
        let exp = expectation(description: "fetch_countries")
        var countriesFetched = false
        
        sut.fetchCountries { success in
            countriesFetched = true
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertTrue(countriesFetched)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
