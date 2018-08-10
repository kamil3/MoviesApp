//
//  AlternativeTitlesViewModel.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 10.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import RxSwift
import RxCocoa

struct AlternativeTitlesViewModel {
    
    let alternativeTitles = BehaviorRelay<[AlternativeTitle]>(value: [])
}
