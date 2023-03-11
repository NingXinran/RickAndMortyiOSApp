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
                print("success: api call")
                print("Total: " + String(model.info.count))
                print("Page result count: " + String(model.info.pages))
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
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
