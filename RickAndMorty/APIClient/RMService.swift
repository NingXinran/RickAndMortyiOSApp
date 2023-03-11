//
//  RMService.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import Foundation

// File responsible for making API calls

/// Primary API service object to get Rick and Morty data
final class RMService {
    /// Shared singleton instance of RMService
    static let shared = RMService()
    
    // privatise constructor so that everyone needs to use the shared instance above
    /// Privatised constructor
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    // Completion is the callback, escaping closure, no arguments returned, void return
    // Accepts an RMRequest type as parameter
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data OR error
    ///   - type: The type of object we expect to get back, e.g. an RMCharacter object, or a list of RMCharacter objects
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,  // 'expecting' is the name reflected when we use the method
                                    completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else { // returns URLRequest?
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in  // callback returns data, response and error
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            // If request was successful, decode the response to an object or raw json
            do {
                let result = try JSONDecoder().decode(type.self, from: data)  // Decode T from the data
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    
    // nullable function if RMRequest object does not have a url
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        // call the method
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
