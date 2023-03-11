//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import Foundation

// The data type for the response when getting all characters

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?  // paging, both are nullable
    }
    
    let info: Info
    let results: [RMCharacter]
}
