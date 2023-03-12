//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"  // cannot change the key because they are linked to the schema from our jjson
        }
    }
}
