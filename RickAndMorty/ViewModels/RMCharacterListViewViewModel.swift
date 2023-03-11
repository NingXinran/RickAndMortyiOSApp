//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import Foundation
import UIKit

// Each model has a single responsibility
// This one makes the API call to get the results

class RMCharacterListViewViewModel: NSObject {  // Now add the data source protocol to this view model?
    func fetchCharacters(){
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) {
            result in switch result {
            case .success(let model):
                print("successful api call")
                print(String(describing: model.results.first?.image ?? "No image"))
                print("Example image URL: ")
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

// Extend the class to comply to the protocol
extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20  // hardcode for now
    }
    /// Function to dequeue to obtain a single cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // dequeue to return a single cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = RMCharacterCollectionViewCellViewModel(
            characterName: "Xinran", characterStatus: .alive, characterImageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        let height = width * 1.5
        return CGSize(
            width: width,
            height: height
        )
    }
}
