//
//  UIView+Ext.swift
//  Muzeler
//
//  Created by Ferhat on 22.02.2024.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
