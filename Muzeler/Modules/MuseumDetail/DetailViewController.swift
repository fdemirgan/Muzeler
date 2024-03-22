//
//  DetailViewController.swift
//  Muzeler
//
//  Created by Ferhat on 23.02.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
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
        detailUpdate()
    }
    
    func detailUpdate(){
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == SegueIdentifier.MuseumMapVC.rawValue else { return }
        if let museum = sender as? MuseumData {
            let destinationVC = segue.destination as! MapViewController
            destinationVC.museum = museum
        }
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.MuseumMapVC.rawValue, sender: museum)
    }
    
    @IBAction func phoneNumberTapped(_ sender: Any) {
        print("Muzenin telefonu aramaya yönlendirilecek.")
    }
    
    
    
    
}
