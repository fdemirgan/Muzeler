//
//  URLSessionServiceManager.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import Foundation
final class URLSessionServiceManager: Networking {
    
    func fetchData<T>(endPoint: Endpointable, parameters: [Parameterable], completion: @escaping (Result<T, MuseumApiError>) -> ()) where T : Decodable {
        
        
        var components = URLComponents(string: endPoint.fullPath)
        components?.queryItems = parameters.map({$0.queryItem})
        
        guard let url = components?.url
        else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.noData))
            }
            
            guard let data = data
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
        }.resume()
    }
}
