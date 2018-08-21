//
//  AlertControllerUtils.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 21.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit
import RxSwift

typealias AlertActionHandler = ((UIAlertAction) -> Void)

extension UIAlertControllerStyle {
    func controller(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let _controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: self
        )
        actions.forEach { _controller.addAction($0) }
        if actions.count == 2 {
            _controller.preferredAction = actions[1]
        }
        return _controller
    }
}

extension String {
    func alertAction(style: UIAlertActionStyle = .default, handler: AlertActionHandler? = nil) -> UIAlertAction {
        return UIAlertAction(title: self, style: style, handler: handler)
    }
}

extension UIViewController {
    func alertSignal(title: String, message: String) -> Observable<Void> {
        return Observable.create({ [weak self] observer in
            let alertController = UIAlertControllerStyle.alert.controller(
                title: title,
                message: message,
                actions: [
                    "Ok".alertAction { _ in
                        observer.onCompleted()
                    }
                ])
            
            self?.present(alertController, animated: true, completion: nil)
            
            return Disposables.create(with: {
                self?.dismiss(animated: true, completion: nil)
            })
        })
    }
}
