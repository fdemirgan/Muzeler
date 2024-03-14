//
//  LocationParameter.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation
enum MuseumParameter: Parameterable {
    
    case apiKey
    case latitude(String)
    case longitude(String)
    case city(String)
    case district(String)
    
    var queryItem: URLQueryItem {
        let apiKey = "qTipth6dVCu9sVyzoeenzY7QV0IuRoLmAORznpitPPzYCab05JZcFXm5eVym"
        switch self {
        case .apiKey:
            return URLQueryItem(name: "apiKey", value: apiKey)
        case .latitude(let latValue):
            return URLQueryItem(name: "latitude", value: "\(latValue)")
        case .longitude(let lonValue):
            return URLQueryItem(name: "longitude", value: "\(lonValue)")
        case .city(let cityValue):
            return URLQueryItem(name: "city", value: "\(cityValue)")
        case .district(let districtValue):
            return URLQueryItem(name: "district", value: "\(districtValue)")
        }
    }
}


