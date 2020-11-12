//
//  ImageService.swift
//  FlagMania
//
//  Created by David Anglin on 11/12/20.
//

import Foundation

enum ImageError: Error {
    case invalidUrl
    case responseFailure
    case serializationError
    case unknownError
}

protocol ImageServiceProtocol {
    func fetchImage(for path: String, completion: @escaping (Result<Data, ImageError>) -> Void)
}

class ImageService: ImageServiceProtocol {
    
    var apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchImage(for path: String, completion: @escaping (Result<Data, ImageError>) -> Void) {
        guard let url = URL(string: path) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        apiClient.get(url: url) { data, error in
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.responseFailure))
                return
            }
            
            completion(.success(data))
        }
    }
}
