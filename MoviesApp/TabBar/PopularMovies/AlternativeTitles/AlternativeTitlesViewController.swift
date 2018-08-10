//
//  AlternativeTitlesViewController.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 10.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit

class AlternativeTitlesViewController: UIViewController {

    // MARK:- Properties
    var viewModel: AlternativeTitlesViewModel!
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("DEALLOC ---- \(self.className)")
    }

}
