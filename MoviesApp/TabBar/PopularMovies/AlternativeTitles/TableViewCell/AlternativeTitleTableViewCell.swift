//
//  AlternativeTitleTableViewCell.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 10.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import UIKit

class AlternativeTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isoNamingLabel: UILabel!
    @IBOutlet weak var isoLabel: UILabel!
    @IBOutlet weak var typeNamingLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var alternativeTitleNamingLabel: UILabel!
    @IBOutlet weak var alternativeTitleLabel: UILabel!
    @IBOutlet weak var typeStackView: UIStackView!
    
    func update(with alternativeTitle: AlternativeTitle) {
        isoNamingLabel.text = "alternative.title.cell.iso.naming.label".localized()
        isoLabel.text = alternativeTitle.iso31661
        typeNamingLabel.text = "alternative.title.cell.type.naming.label".localized()
        typeLabel.text = alternativeTitle.type
        alternativeTitleNamingLabel.text = "alternative.title.cell.naming.label".localized()
        alternativeTitleLabel.text = alternativeTitle.title
        //type is often missing in response
        typeStackView.isHidden = ((alternativeTitle.type?.count ?? 0) == 0)
    }
}

extension AlternativeTitleTableViewCell: NibLoadableView {}
