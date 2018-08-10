//
//  AlternativeTitlesViewController.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 10.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class AlternativeTitlesViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    var viewModel: AlternativeTitlesViewModel!
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }
    
    deinit {
        print("DEALLOC ---- \(className)")
    }
    
    // MARK:- Private
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        tableView.tableFooterView = UIView()
        tableView.register(AlternativeTitleTableViewCell.self)
    }
    
    private func setupBindings() {
        viewModel
            .alternativeTitles
            .bind(to: tableView.rx.items(cellIdentifier: AlternativeTitleTableViewCell.reuseIdentifier, cellType: AlternativeTitleTableViewCell.self))  { (_, alternativeTitle, cell) in
                cell.update(with: alternativeTitle)
            }
            .disposed(by: rx.disposeBag)
    }

}
