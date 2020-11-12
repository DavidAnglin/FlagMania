//
//  CountriesViewModel.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import Foundation

protocol CountriesListViewModelContract {
    var countries: [Country] { get set }
    
    func getTitle() -> String
    func fetchCountries(completion: @escaping (Bool) -> Void)
}

class CountriesListViewModel: CountriesListViewModelContract {
    
    var countries: [Country] = []
    
    var apiClient: CountriesServiceProtocol!
    
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
}
