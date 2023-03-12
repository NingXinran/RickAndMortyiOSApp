//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 12/3/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    /// Private attributes
    private let character: RMCharacter
    
    /// Constructor Create a detailView with a RMCharacter
    init(character: RMCharacter){
        self.character = character
    }
    
    /// Public attributes
    public var title: String {
        character.name.uppercased()
    }
}
