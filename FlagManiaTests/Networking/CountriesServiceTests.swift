//
//  CountriesServiceTests.swift
//  FlagManiaTests
//
//  Created by David Anglin on 11/12/20.
//

import XCTest
@testable import FlagMania

class CountriesServiceTests: XCTestCase {

    func test_country_parsed_response() throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "CountryData", ofType: "json"),
              let jsonString = try? String(contentsOfFile: path, encoding: .utf8),
              let data = jsonString.data(using: .utf8) else {
            XCTFail("Could not find json file.")
            return
        }
        
        let decoder = JSONDecoder()
        let country = try decoder.decode(Country.self, from: data)
        
        XCTAssertEqual(country.name, "Afghanistan")
        XCTAssertEqual(country.alpha2Code, "AF")
        XCTAssertEqual(country.capital, "Kabul")
        XCTAssertEqual(country.flagURL, "https://www.countryflags.io/AF/flat/64.png")
    }
    
    func test_countries_completion_called() {
        let countryExpectation = expectation(description: "countryApiCall")
        
        var completionCalled = false
        let apiClient = CountriesService(apiClient: APIClient())
        
        apiClient.fetchCountries { (_) in
            completionCalled = true
            countryExpectation.fulfill()
        }
        
        wait(for: [countryExpectation], timeout: 5.0)
        XCTAssertTrue(completionCalled)
    }
}
