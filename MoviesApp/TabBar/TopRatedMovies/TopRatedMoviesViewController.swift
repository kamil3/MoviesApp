//
//  TopRatedMoviesViewController.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TopRatedMoviesViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- Properties
    var viewModel: TopRatedMoviesViewModel!

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
        setupUI()
        setupBindings()
    }
    
    // MARK:- Private
    private func setupUI() {
        title = "tab.bar.item.0".localized()
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 15)
        collectionView.register(TopRatedMovieCollectionViewCell.self)
        Style.defaultBackgroundViewStyle.apply(to: collectionView)
    }
    
    private func setupBindings() {
        viewModel
            .topRatedMovies
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: TopRatedMovieCollectionViewCell.reuseIdentifier, cellType: TopRatedMovieCollectionViewCell.self)) {_, movie, cell in
                cell.update(with: movie)
            }
            .disposed(by: rx.disposeBag)

    }

}

// MARK:- UICollectionViewDelegateFlowLayout
extension TopRatedMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: 1.5 * itemSize)
    }
}
