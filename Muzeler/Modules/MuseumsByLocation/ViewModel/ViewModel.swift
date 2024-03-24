//
//  ViewModel.swift
//  Muzeler
//
//  Created by Ferhat on 22.02.2024.
//

import Foundation

final class ViewModel {
    init(){
        LocationManager.shared.locationDelegate = self
    }
   private var dataProvider = DataProvider(serviceManager: URLSessionServiceManager())
    public var museums: [MuseumData] = []
    public var delegate: MuseumTableViewModelDelegate?
    private var latitude: Double?
    private var longitude: Double?
    private var parameters: [MuseumParameter] {
        return [.apiKey, .latitude(String(latitude ?? 0.0)), .longitude(String(longitude ?? 0.0))]
    }
    func fetchMuseumList(){
        dataProvider.fetchLocationMuseums(endpoint: .location, parameters: parameters) { result in
            switch result {
            case .success(let success):
                if let museumsData = success.data{
                    self.museums = museumsData
                }
                self.notify(with: .reloadTableView)
            case .failure(let failure):
                self.notify(with: .error(failure))
            }
        }
    }
    func notify(with notify: NotifyViewModel){
        DispatchQueue.main.async {
            self.delegate?.notify(notify)
        }
    }
}
extension ViewModel: LocationManagerDelegate {
    func didUpdateLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
