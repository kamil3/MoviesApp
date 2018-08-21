//
//  MainTabBarController.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTranslations()
    }
    
    // MARK:- Private
    private func setupTranslations() {
        let topRatedMoviesNavController = viewControllers?[0] as! UINavigationController
        topRatedMoviesNavController.tabBarItem.title = "tab.bar.item.0".localized()
        let popularMoviesNavController = viewControllers?[1] as! UINavigationController
        popularMoviesNavController.tabBarItem.title = "tab.bar.item.1".localized()
    }

}
