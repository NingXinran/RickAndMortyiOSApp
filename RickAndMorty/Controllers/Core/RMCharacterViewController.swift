//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import UIKit

/// Controller to show and serach for characters
final class RMCharacterViewController: UIViewController {
    
    private let characterListView = RMCharacterListView()  // Create an instance of the view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground  // Light or Dark depending on system
        title = "Characters"
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
