//
//  Country.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import Foundation

struct Country: Codable {
    let name: String
    let alpha2Code: String
    let capital: String
    let population: Int
    let timezones: [String]
    
    var flagURL: String {
        return "https://www.countryflags.io/\(alpha2Code)/flat/64.png"
    }
}
