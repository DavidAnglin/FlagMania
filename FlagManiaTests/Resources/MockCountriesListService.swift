//
//  MockCountriesListService.swift
//  FlagManiaTests
//
//  Created by David Anglin on 11/12/20.
//

@testable import FlagMania
import Foundation

final class MockCountriesListService: CountriesServiceProtocol {
    var countries: [Country] = []
    
    func fetchCountries(completion: @escaping (Result<[Country], FetchError>) -> Void) {
        completion(.success(countries))
    }
}
