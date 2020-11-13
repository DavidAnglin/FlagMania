//
//  CountriesListViewTests.swift
//  FlagManiaTests
//
//  Created by David Anglin on 11/12/20.
//

@testable import FlagMania
import XCTest

class CountriesListViewTests: XCTestCase {

    func test_countryList_load() {
        let service = MockCountriesListService()
        let viewModel = CountriesListViewModel(apiClient: service)
        let viewController = CountriesListViewController(viewModel: viewModel)
        
        _ = viewController.view

        XCTAssertNotNil(viewController.tableView)
    }
}
