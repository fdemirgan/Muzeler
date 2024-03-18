//
//  LocationMuesumDataProvider.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation
final class DataProvider: DataProviderProtocol {
    var serviceManager: Networking
    init(serviceManager: Networking) {
        self.serviceManager = serviceManager
    }
    func fetchLocationMuseums(endpoint: MuseumEndpoints, parameters: [MuseumParameter], completion: @escaping (Result<Museum, MuseumApiError>) -> ()) {
        serviceManager.fetchData(endPoint: endpoint, parameters: parameters, completion: completion)
    }
    func fetchCities(endpoint: MuseumEndpoints, parameters: [MuseumParameter], completion: @escaping (Result<CitiesInfo, MuseumApiError>) -> Void) {
        serviceManager.fetchData(endPoint: endpoint, parameters: parameters, completion: completion)
    }
    func fetchDistricts(endpoint: MuseumEndpoints, parameters: [MuseumParameter], completion: @escaping (Result<CitiesInfo, MuseumApiError>) -> Void) {
        serviceManager.fetchData(endPoint: endpoint, parameters: parameters, completion: completion)
    }
    func fetchSourceMuseums(endpoint: MuseumEndpoints, parameters: [MuseumParameter], completion: @escaping (Result<Museum, MuseumApiError>) -> Void) {
        serviceManager.fetchData(endPoint: endpoint, parameters: parameters, completion: completion)
    }
}
