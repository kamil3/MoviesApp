//
//  AlternativeTitleTableViewCell.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 10.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit

class AlternativeTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isoLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var alternativeTitleLabel: UILabel!
    
    func update(with alternativeTitle: AlternativeTitle) {
        isoLabel.text = ("alternative.title.cell.iso.label".localized() + ": " + (alternativeTitle.iso31661 ?? ""))
        //type is often missing in response
        typeLabel.text = ((alternativeTitle.type?.count ?? 0) > 0) ? ("alternative.title.cell.type.label".localized() + ": " + alternativeTitle.type!) : ""
        alternativeTitleLabel.text = ("alternative.title.cell.title.label".localized() + ": " + (alternativeTitle.title ?? ""))
    }
}

extension AlternativeTitleTableViewCell: NibLoadableView {}
