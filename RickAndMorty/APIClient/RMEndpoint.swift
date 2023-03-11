//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import Foundation

// THe paths we can go down to get data
// Location, character and episode
// Get from rickandmortyapi.com website

// model these instead of having hardcode strings, using enum

// will get back to understand @frozen
/// Represents unique API endpoints
@frozen enum RMEndpoint: String {  // raw value type of string, thus it will return e.g. "character"
    /// Endpoint to get character information
    case character
    /// Endpoint to get location information
    case location
    /// Endpoint to get episode information
    case episode
}
