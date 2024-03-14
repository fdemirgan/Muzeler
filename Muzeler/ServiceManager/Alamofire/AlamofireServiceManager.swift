//
//  AlamofireServiceManager.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation
import Alamofire
class AlamofireServiceManager: Networking {
    func fetchData<T>(endPoint: Endpointable, parameters: [Parameterable], completion: @escaping (Result<T, MuseumApiError>) -> ()) where T : Decodable {
        
        var components = URLComponents(string: endPoint.fullPath)
        components?.queryItems = parameters.map({ $0.queryItem })
        
        guard let url = components?.url
        else {
            completion(.failure(.invalidUrl))
            return
        }
        
        AF.request(url, method: .get).response { response in
            
            if response.error != nil {
                completion(.failure(.noData))
            }
            
            guard let data = response.data
            else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodedData = try jsonDecoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(.decodeFail))
            }
        }
    }
}
