//
//  Networking.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation
enum MuseumApiError: String, Error {
    case noData = "Data alınamadı."
    case decodeFail = "Data decode edilirken hata oluştu."
    case invalidUrl = "Geçersiz URL"
    case parametreFail = "Parametre hatalı"
}

protocol Networking {
    func fetchData<T: Decodable>(endPoint: Endpointable, parameters: [Parameterable], completion: @escaping (Result<T, MuseumApiError>) ->())
}
