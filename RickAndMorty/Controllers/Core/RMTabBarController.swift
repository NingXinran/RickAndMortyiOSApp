//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Xinran Ning on 11/3/23.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTabs()  // Run the function we wrote!
    }
    
    private func setUpTabs() {  // Link the view controllers to this tab
        // Create an instance for each controller and attach to this controller
        let charactersVC = RMCharacterViewController()
        let locationsVC = RMLocationViewController()
        let episodesVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        
        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        // wrap each VC in a navigation controller
        let charactersNC = UINavigationController(rootViewController: charactersVC)
        let locationsNC = UINavigationController(rootViewController: locationsVC)
        let episodesNC = UINavigationController(rootViewController: episodesVC)
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        
        charactersNC.tabBarItem = UITabBarItem(title: "Characters",
                                               image: UIImage(systemName: "person"),
                                               tag: 1)
        locationsNC.tabBarItem = UITabBarItem(title: "Locations",
                                              image: UIImage(systemName: "building.2"),
                                              tag: 2)
        episodesNC.tabBarItem = UITabBarItem(title: "Episodes",
                                             image: UIImage(systemName: "tv"),
                                             tag: 3)
        settingsNC.tabBarItem = UITabBarItem(title: "Settings",
                                             image: UIImage(systemName: "gear"),
                                             tag: 4)
        
        let NCList = [
            charactersNC,
            locationsNC,
            episodesNC,
            settingsNC
        ]
        
        for nc in NCList {
            nc.navigationBar.prefersLargeTitles = true
        }
        
        // function that is inherited from UITabBarController
        setViewControllers(
            NCList,
            animated: true
        )
    }
}

