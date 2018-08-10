//
//  NSObjectUtils.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 10.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import Foundation

extension NSObject {
    @objc var className: String {
        return String(describing: type(of: self))
    }
    
    @objc class var className: String {
        return String(describing: self)
    }
}
