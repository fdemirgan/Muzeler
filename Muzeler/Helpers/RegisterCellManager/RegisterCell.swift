//
//  RegisterCell.swift
//  Muzeler
//
//  Created by Ferhat on 29.02.2024.
//

import Foundation
import UIKit
final class RegisterCellManager {

    static let shared = RegisterCellManager()

    private init(){ }

    func registerCells( tableViewCell: UITableViewCell.Type, tableView: UITableView) {
        let museumCellName = String(describing: tableViewCell)
        let museumCellNib = UINib(nibName: museumCellName, bundle: nil)
        tableView.register(museumCellNib, forCellReuseIdentifier: museumCellName)
    }
}
