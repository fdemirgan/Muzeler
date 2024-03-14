//
//  Protocol.swift
//  Muzeler
//
//  Created by Ferhat on 27.02.2024.
//

import Foundation
protocol MuseumTableViewModelDelegate: AnyObject {
    func notify(_ notify: NotifyViewModel)
}
