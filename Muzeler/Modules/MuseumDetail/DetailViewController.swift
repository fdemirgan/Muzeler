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
        
        let tapWebSite = UITapGestureRecognizer(target: self, action: #selector(openWebSite))
        webSiteLbl.isUserInteractionEnabled = true
        webSiteLbl.addGestureRecognizer(tapWebSite)
        
        let tapEmail = UITapGestureRecognizer(target: self, action: #selector(openEmail))
        eMailLbl.isUserInteractionEnabled = true
        eMailLbl.addGestureRecognizer(tapEmail)
        
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
    
    @objc func openWebSite() {
        guard let urlString = museum?.website, let url = URL(string: urlString) else {
            print(MuseumDetailTappedError.webSite)
            return
        }
        UIApplication.shared.open(url)
    }
    
    @objc func openEmail() {
        guard let emailAdress = museum?.email, let url = URL(string: "mailto:\(emailAdress)") else {
            print(MuseumDetailTappedError.emailAdress)
            return
        }
        UIApplication.shared.open(url)
    }
    
    
    @IBAction func mapTapped(_ sender: Any) {
        print("Muzenin konumu haritada gösterilecek.")
    }
    
    @IBAction func phoneNumberTapped(_ sender: Any) {
        // müzeler genel müdürlüğü tel: 03124708000
        // Çağrıyı simüle etmek için gerçek bir cihaz gereklidir.
        guard let phoneNumber = museum?.phone, let phoneURL = URL(string: "tel://\(phoneNumber)") else { print(MuseumDetailTappedError.phoneNumber)
            return }
        UIApplication.shared.open(phoneURL)
    }
}
