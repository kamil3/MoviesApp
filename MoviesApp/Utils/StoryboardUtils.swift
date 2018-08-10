//
//  StoryboardUtils.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 10.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateViewControllerOfType<ViewController: UIViewController>(_: ViewController.Type) -> ViewController {
        guard let viewController = instantiateViewController(withIdentifier: ViewController.storyboardIdentifier) as? ViewController else {
            fatalError("Could not instantiate view controller with identifier: \(ViewController.storyboardIdentifier)")
        }
        return viewController
    }
    
    func instantiateInitialViewControllerOfType<ViewController: UIViewController>(_: ViewController.Type) -> ViewController {
        guard let viewController = instantiateInitialViewController() as? ViewController else {
            fatalError("Could not instantiate initial view controller of type: \(ViewController.self)")
        }
        return viewController
    }
    
}
