//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import UIKit

/// Controller to show and serach for characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground  // Light or Dark depending on system
        title = "Characters"
        
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
