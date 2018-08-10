//
//  PopularMoviesViewController.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class PopularMoviesViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    var viewModel: PopularMoviesViewModel!
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }
    
    // MARK:- Private
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        tableView.tableFooterView = UIView()
        tableView.register(PopularMovieTableViewCell.self)
    }

    private func setupBindings() {
        viewModel
            .popularMovies
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: PopularMovieTableViewCell.reuseIdentifier, cellType: PopularMovieTableViewCell.self))  { (_, movie, cell) in
                cell.update(with: movie)
            }
            .disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] movie in
                let alternativeTitlesViewController = UIStoryboard.alternativeTitlesViewControllerStoryboard().instantiateInitialViewControllerOfType(AlternativeTitlesViewController.self) as AlternativeTitlesViewController
                alternativeTitlesViewController.title = movie.title
                alternativeTitlesViewController.viewModel.alternativeTitles.value = movie.alternativeTitles
                self?.navigationController?.pushViewController(alternativeTitlesViewController, animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected
            .do(onNext: { [unowned self] indexPath in
                self.tableView.deselectRow(at: indexPath, animated: false)
            })
            .subscribe()
            .disposed(by: rx.disposeBag)
    }
}
