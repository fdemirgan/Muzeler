//
//  LocationTableViewCell.swift
//  Muzeler
//
//  Created by Ferhat on 22.02.2024.
//

import UIKit

class MuseumTableViewCell: UITableViewCell {

    @IBOutlet private weak var museumImage: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    @IBOutlet private weak var distanceLbl: UILabel!
    @IBOutlet private weak var pointLbl: UILabel!
    func prepareCell (with model: CellViewModel){
        nameLbl.text = model.name
        descriptionLbl.text = model.description
        if distanceLbl.text != "0.0 km  "{
            distanceLbl.text = model.distance
        }else {
            distanceLbl.isHidden = true
            pointLbl.isHidden = true
        }
    }
}
