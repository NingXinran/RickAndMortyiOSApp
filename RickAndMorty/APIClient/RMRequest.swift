//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import Foundation

// Build the request by defining a native type, instead of passing in raw data

// an instance of this class is one request, which includes all the data we need
// endpoint, additional path components, etc.
/// Object that represents a single API call
final class RMRequest {
    // What to know: Base url, endpoint, (additional) path component
    // Query parameters? (optional): filter with location, name, type (e.g. ?name=rick&status=alive)
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint  // use the enum we created
    /// Path components for API, if any. Not nullable.
    private let pathComponents: [String]
    /// Query parameters for API, if any. Not nullable.
    private let queryParameters: [URLQueryItem]
    
    /// Constructed URL for the API request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            // Need value and name, and '&'
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// Constructed urlString as a URL-typed variable
    public var url: URL? {  // Create and return a public constructed url
        return URL(string: urlString)
    }
    
    /// Desired HTTP method, hardcoded to GET
    public let httpMethod = "GET"  // Only GET are allowed for the rick and morty API website
    
    /// Construct Request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components, if any
    ///   - queryParameters: Collection of query parameters, if any
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],  // default is empty array
                queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

// Add extension to the RMRequest object above
extension RMRequest {
    // Create some request variables that we can use
    static let listCharactersRequest = RMRequest(endpoint: .character)
}

