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

    func showAlert(title: String, message: String, vc: UIViewController, onRefresh: @escaping () -> Void){

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        let refreshButton = UIAlertAction(title: "Yenile", style: .default) { action in
             onRefresh()
        }
        alert.addAction(cancelButton)
        alert.addAction(refreshButton)
        vc.present(alert, animated: true)
    }
}
