//
//  ViewControllerUtils.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 10.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable: class { }

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
