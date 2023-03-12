//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 12/3/23.
//

import UIKit

/// Want a viewController that we can 'push'
/// Controller to show information about single character
final class RMCharacterDetailViewController: UIViewController {
    private let viewModel: RMCharacterDetailViewViewModel
    
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel  // can call super.init second?
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
//


}
