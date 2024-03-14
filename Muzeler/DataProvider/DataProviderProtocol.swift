//
//  LocationMuseumDataProviderProtocol.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation
protocol DataProviderProtocol {
    func fetchLocationMuseums (endpoint: MuseumEndpoints, parameters: [MuseumParameter], completion: @escaping (Result<Museum, MuseumApiError>) -> Void)
    
    func fetchCities (endpoint: MuseumEndpoints, parameters: [MuseumParameter], completion: @escaping (Result<CitiesInfo, MuseumApiError>) -> Void)
    
    func fetchDistricts (endpoint: MuseumEndpoints, parameters: [MuseumParameter], completion: @escaping(Result<CitiesInfo, MuseumApiError>) -> Void)
    
    func fetchSourceMuseums (endpoint: MuseumEndpoints, parameters:[MuseumParameter], completion: @escaping(Result<Museum, MuseumApiError>) -> Void)
}
