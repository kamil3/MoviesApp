//
//  NibLoadableView.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    static var NibName: String {
        return String(describing: self)
    }
}
