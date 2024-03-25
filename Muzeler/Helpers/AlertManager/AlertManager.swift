//
//  AlertManager.swift
//  Muzeler
//
//  Created by Ferhat on 24.03.2024.
//

import UIKit

final class AlertManager {
    static let shared = AlertManager()

    private init(){ }

    func showAlert(title: String, message: String, vc: UIViewController){

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelButton)
        vc.present(alert, animated: true)
    }
}
