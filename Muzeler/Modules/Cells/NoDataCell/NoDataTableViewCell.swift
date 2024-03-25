//
//  NoDataTableViewCell.swift
//  Muzeler
//
//  Created by Ferhat on 25.03.2024.
//

import UIKit

final class NoDataTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    var viewModel: ViewModel?
    
    func prepareCell(networkStatus status: Bool){
        messageLbl.text = status ? "Veri Bulunamadı" : "İnternet Bağlantınızı Kontrol Ediniz !"
        refreshButton.isHidden = status ? true : false
    }
    
    @IBAction func refreshTapped(_ sender: UIButton) {
        viewModel?.fetchMuseumList()
    }
}
