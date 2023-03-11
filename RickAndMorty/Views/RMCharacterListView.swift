//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import UIKit

/// View that handles showing a list of characters, loader etc.
final class RMCharacterListView: UIView {
    
    private let viewModel = RMCharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical  // if its a dot its likely an enum?
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true  // hide when data is still loading
        collectionView.alpha = 0  // opacity is 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false  // keep size constant
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, spinner)  // Add the spinner to the subview of this view
        
        addConstraints()  // Add the layout constraints to this spinner
        
        spinner.startAnimating()
        
        // Request to fetch characters
        viewModel.fetchCharacters()
        
        // Remove the spinner, show results in a grid
        setUpCollectionView()
        
    }

    required init?(coder: NSCoder) {  // NSCoder is a protocol that supports encoding and decoding into data buffer
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Pin to the sides of the screen
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {  // delay by 2 seconds!!
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1
            }
        })
    }

}
