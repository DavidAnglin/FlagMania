//
//  CountriesService.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import Foundation

enum FetchError: Error {
    case invalidUrl
    case responseFailure
    case serializationError
    case unknownError
}

enum NetworkingConstants {
    static let countryBaseURL = "https://restcountries.eu/rest/v2/all"
}

protocol CountriesServiceProtocol {
    func fetchCountries(completion: @escaping (Result<[Country], FetchError>) -> Void)
}

class CountriesService: CountriesServiceProtocol {
    
    var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchCountries(completion: @escaping (Result<[Country], FetchError>) -> Void) {
        guard let url = URL(string: NetworkingConstants.countryBaseURL) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let urlQueryItems = [URLQueryItem(name: "fields", value: "name;alpha2Code;capital;population;timezones")]
        
        components?.queryItems = urlQueryItems
        
        apiClient.get(url: url) { data, error in
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.responseFailure))
                return
            }

            let decoder = JSONDecoder()
            if let countries = try? decoder.decode([Country].self, from: data) {
                completion(.success(countries))
                print("Countries \(countries)")
            } else {
                completion(.failure(.serializationError))
            }
        }
    }
}
