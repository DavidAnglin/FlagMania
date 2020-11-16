//
//  CountryDetailViewModel.swift
//  FlagMania
//
//  Created by David Anglin on 11/16/20.
//

import Foundation

protocol CountryDetailVMContract {
    func getCountryName() -> String
    func getCapital() -> String
    func getPopulation() -> String
    func getTimezones() -> [String]
}

class CountryDetailViewModel: CountryDetailVMContract {
    
    let country: Country
    
    init(country: Country) {
        self.country = country
    }

    func getCountryName() -> String {
        return country.name
    }
    
    func getCapital() -> String {
        return country.capital
    }
    
    func getPopulation() -> String {
        return "\(country.population)"
    }
    
    func getTimezones() -> [String] {
        return country.timezones
    }
}
