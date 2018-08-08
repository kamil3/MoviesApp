//
//  PopularMovieTableViewCell.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 08.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var alternativeTitlesCountLabel: UILabel!
    
    func update(with movie: Movie) {
        movieTitleLabel.text = movie.title
    }
    
}
