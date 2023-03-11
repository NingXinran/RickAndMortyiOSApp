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
        
        // Create a request
        let request = RMRequest(endpoint: .character,
                                pathComponents: ["1"],
                                queryParameters: [
                                    URLQueryItem(name:"name", value:"rick"),
                                    URLQueryItem(name:"status", value:"alive")
                                ])
        print(request.url)
        
        RMService.shared.execute(request,
                                 expecting: RMCharacter.self) { result in
            
        }
        
    }
    



}
