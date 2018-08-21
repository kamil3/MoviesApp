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
    private let movies = BehaviorRelay<[Movie]>(value: [])
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
        setupUI()
        setupBindings()
    }
    
    // MARK:- Private
    private func setupUI() {
        title = "popular.movies.title".localized()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        tableView.tableFooterView = UIView()
        tableView.register(PopularMovieTableViewCell.self)
    }

    private func setupBindings() {
        viewModel
            .popularMovies
            .bind(to: movies)
            .disposed(by: rx.disposeBag)
        
        movies
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: PopularMovieTableViewCell.reuseIdentifier, cellType: PopularMovieTableViewCell.self))  { (_, movie, cell) in
                cell.update(with: movie)
            }
            .disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] movie in
                let alternativeTitlesViewController = UIStoryboard.alternativeTitlesViewControllerStoryboard().instantiateInitialViewControllerOfType(AlternativeTitlesViewController.self) as AlternativeTitlesViewController
                alternativeTitlesViewController.title = movie.title
                alternativeTitlesViewController.viewModel.alternativeTitles.accept(movie.alternativeTitles)
                self?.navigationController?.pushViewController(alternativeTitlesViewController, animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected
            .do(onNext: { [unowned self] indexPath in
                self.tableView.deselectRow(at: indexPath, animated: false)
            })
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        viewModel
            .alertMessage
            .observeOn(MainScheduler.instance)
            .flatMap { [weak self] error -> Observable<Void> in
                guard let strongSelf = self else { return Observable.empty() }
                return strongSelf.alertSignal(title: "Error", message: error.localizedDescription)
                                 .take(3.0, scheduler: MainScheduler.instance)
            }
            .subscribe(onDisposed: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK:- UITableViewDelegate
extension PopularMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return movies.value[indexPath.row].alternativeTitles.count > 0 ? indexPath : nil
    }
}
