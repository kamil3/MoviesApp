//
//  OptionalTypeUtils.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 22.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

extension Optional {
    func asStringOrEmpty() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return ""
        }
    }
    
    func asStringOrNilText() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return "(nil)"
        }
    }
}
