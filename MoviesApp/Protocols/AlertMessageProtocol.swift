//
//  AlertMessageProtocol.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 23.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit
import RxSwift

protocol AlertMessageProtocol {}

extension AlertMessageProtocol where Self: UIViewController {
    func bindErrorMessage(with alertMessageSequence: Observable<Error>) {
        alertMessageSequence
            .observeOn(MainScheduler.instance)
            .flatMap { [weak self] error -> Observable<Void> in
                guard let strongSelf = self else { return Observable.empty() }
                return strongSelf.alertSignal(title: "error.text".localized(), message: error.localizedDescription)
                    .take(3.0, scheduler: MainScheduler.instance)
            }
            .subscribe(onDisposed: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
    }
}
