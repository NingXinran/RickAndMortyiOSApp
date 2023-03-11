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
    
    // Completion is the callback, escaping closure, no arguments returned, void return
    // Accepts an RMRequest type as parameter
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
