//
//  Cities.swift
//  Muzeler
//
//  Created by Ferhat on 22.02.2024.
//

import Foundation

struct CitiesInfo: Decodable {
    var endpoint: String?
    var rowCount: Int?
    var data: [CitiesData]?
}

struct CitiesData: Decodable {
    var cities: String?
    var slug: String?
}
