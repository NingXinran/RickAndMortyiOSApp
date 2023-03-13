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

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

/// View model to handle character list view logic
class RMCharacterListViewViewModel: NSObject {  // Now add the data source protocol to this view model?
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [RMCharacter] = [] {
        didSet {  // Whenever the value of characters is assigned, do the following
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterImageURL: URL(string: character.image))
                cellViewModels.append(viewModel)
            }
            
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil  // Default value is nil
    
    /// Fetch initial set of characters (count: 20)
    func fetchCharacters(){
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) {
            [weak self] result in switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info  // Has next?
                self?.characters = results
                self?.apiInfo = info
                // Trigger the update of the view
                DispatchQueue.main.async {
                    // Tell the delegate that the initial characters were loaded
                    self?.delegate?.didLoadInitialCharacters()
                }
                
//                let info = responseModel.info  // Pagination urls
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters() {
        // Fetch characters here
        isLoadingMoreCharacters = true  // Update this var so we only fetch once
        
    }
    
    public var shouldShowLoadMoreInidicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - CollectionView

// Extend the class to comply to the protocol
extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    /// Function to dequeue to obtain a single cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // dequeue to return a single cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]  // only have one section, but looking at row
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
    
    /// Handling a tap on a cell
    /// - Parameters:
    ///   - collectionView: The characterListCollectionView
    ///   - indexPath: The position of the item we are clicking on. This is provided as an argument to the function.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        // Notify the characterViewController
        delegate?.didSelectCharacter(character)  // Informs the collectionView that we have selected the given character
    }
    
    /// Function to dequeue (i.e. show) )the footerLoadingCollectionReusableView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        /// shouldShowLoadMoreIndicator is a variable
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        // Forcibly cast as a LoadingCollectionReusableView and then start animating the spinner
        footer.startAnimating() 
        return footer
    }
    
    /// Function to set the size of the footer that was dequeued
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        /// Result of this function is a CGSize. Want width to be same as collectionView; height is hardcoded
        guard shouldShowLoadMoreInidicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

// MARK: - ScrollView
extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Only want to print it once
        guard shouldShowLoadMoreInidicator, !isLoadingMoreCharacters else {
            return
        }
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        // How we can know we are at the bottom
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            fetchAdditionalCharacters()
        }
    }
}
