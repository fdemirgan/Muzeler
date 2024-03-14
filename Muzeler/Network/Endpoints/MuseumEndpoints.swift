//
//  MuseumEndPoints.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation
enum MuseumEndpoints: Endpointable {
    
    case location
    case cities
    case museum
    
    var baseURL: String {
        return "https://www.nosyapi.com/apiv2/service/"
    }
    var rawValue: String {
        switch self {
        case .location:
           return "museum/locations"
        case .cities:
            return "museum/cities"
        case .museum:
            return "museum"
        }
    }
    var fullPath: String {
        return baseURL + rawValue
    }
}
