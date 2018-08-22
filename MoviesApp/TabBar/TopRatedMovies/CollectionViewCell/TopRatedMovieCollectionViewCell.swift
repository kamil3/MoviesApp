//
//  TopRatedMovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 22.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit
import Kingfisher
import SwinjectStoryboard

class TopRatedMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var voteCountNamingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var voteAverageNamingLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    static let imageURLString = SwinjectStoryboard.defaultContainer.resolve(AppConfig.self)!.imagesURL
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
    }
    
    func update(with movie: Movie) {
        let imageUrl: URL? = (movie.posterPath != nil) ? URL(string: "\(TopRatedMovieCollectionViewCell.imageURLString)\(ImageSizeConstants.TopRatedSize)/\(movie.posterPath!)") : nil
        imageView.kf.setImage(with: imageUrl)
        movieTitleLabel.text = movie.title
        voteCountNamingLabel.text = "top.rated.movies.cell.vote.count.naming.label".localized()
        voteCountLabel.text = movie.voteCount.asStringOrEmpty()
        voteAverageNamingLabel.text = "top.rated.movies.cell.vote.average.naming.label".localized()
        voteAverageLabel.text = movie.voteAverage.asStringOrEmpty()
    }
}

extension TopRatedMovieCollectionViewCell: NibLoadableView {}
