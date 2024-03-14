//
//  DetailViewController.swift
//  Muzeler
//
//  Created by Ferhat on 23.02.2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var museumImage: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var descrpitonLbl: UILabel!
    @IBOutlet private weak var workingtimeLbl: UILabel!
    @IBOutlet private weak var addressLbl: UILabel!
    @IBOutlet private weak var eMailLbl: UILabel!
    @IBOutlet private weak var detailLbl: UILabel!
    @IBOutlet private weak var webSiteLbl: UILabel!
    
    var museum: MuseumData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let museum = museum {
            nameLbl.text = museum.name
            descrpitonLbl.text = museum.description
            workingtimeLbl.text = museum.workingTime
            addressLbl.text = museum.address
            eMailLbl.text = museum.email
            detailLbl.text = "Giriş Ücreti: \(museum.details ?? "")"
            webSiteLbl.text = museum.website
            
        }
    }
    
    
    
    
    @IBAction func mapTapped(_ sender: Any) {
        print("Muzenin konumu haritada gösterilecek.")
    }
    
    @IBAction func phoneNumberTapped(_ sender: Any) {
        print("Muzenin telefonu aramaya yönlendirilecek.")
    }
    
    
    
    
}
