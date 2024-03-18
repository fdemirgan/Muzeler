//
//  ViewModel.swift
//  Muzeler
//
//  Created by Ferhat on 22.02.2024.
//

import Foundation
final class CellViewModel {
    
    let museum: MuseumData
    init(museum: MuseumData) {
        self.museum = museum
    }
    var name: String {
        return museum.name?.uppercased() ?? ""
    }
    var description: String {
        return museum.description ?? ""
    }
    var distance: String {
        return "\(museum.distanceKm ?? 0.0) km  "
    }
}
