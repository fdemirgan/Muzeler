//
//  CustomCalloutView.swift
//  Muzeler
//
//  Created by Ferhat on 31.03.2024.
//

import UIKit

class CustomCalloutView: UIView {

//    @IBOutlet weak var museumNameLbl: UILabel!
    var onCancelTapped: (() -> Void)?
    var onNavigateTapped: (() -> Void)?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 233, height: 34)
    }
    
    @IBAction func cancelTapped(_ sender: UIButton){
        onCancelTapped?()
    }
    
    @IBAction func navigateTapped(_ sender: UIButton){
        onNavigateTapped?()
    }
    
    class func instanceFromNib() -> CustomCalloutView {
        let xibName = "CustomCalloutView"
        let customCallout = UINib(nibName: xibName, bundle: nil)
        let customCallOutView = customCallout.instantiate(withOwner: nil, options: nil).first as! CustomCalloutView
        return customCallOutView
    }

}
