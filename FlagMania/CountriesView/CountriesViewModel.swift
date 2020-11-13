//
//  CountriesViewModel.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import Foundation

protocol CountriesListViewModelContract {
    var countryCount: Int { get }
    
    func getTitle() -> String
    func fetchCountries(completion: @escaping (Bool) -> Void)
    func getCountry(for row: Int) -> Country?
}

class CountriesListViewModel: CountriesListViewModelContract {
    
    private var countries: [Country] = []
    private var apiClient: CountriesServiceProtocol!
    
    var countryCount: Int {
        return countries.count
    }
    
    init(apiClient: CountriesServiceProtocol) {
        self.apiClient = apiClient
    }
    
    func getTitle() -> String {
        return "Country List"
    }
    
    func fetchCountries(completion: @escaping (Bool) -> Void) {
        apiClient.fetchCountries { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let countries):
                strongSelf.countries = countries
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func getCountry(for row: Int) -> Country? {
        guard row < countries.count else { return nil }
        return countries[row]
    }
}
