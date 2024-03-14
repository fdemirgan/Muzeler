//
//  Museum.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation


struct Museum: Decodable {
    var rowCount: Int?
    var endpoint: String?
    var data: [MuseumData]?
}

struct MuseumData: Decodable {
    var name: String?
    var description: String?
    var address: String?
    var workingTime: String?
    var details: String?
    var latitude: Double?
    var longitude: Double?
    var phone: String?
    var email: String?
    var website: String?
    var city: String?
    var district: String?
    var distanceKm: Double?
}
