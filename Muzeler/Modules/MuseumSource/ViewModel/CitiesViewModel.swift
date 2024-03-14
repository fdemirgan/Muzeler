//
//  ViewModel.swift
//  Muzeler
//
//  Created by Ferhat on 22.02.2024.
//

import Foundation
final class CitiesViewModel {
    private var dataProvider = DataProvider(serviceManager: URLSessionServiceManager())
    private var cityParameters: [MuseumParameter] = [.apiKey]
    private var districtParameters: [MuseumParameter] = [.apiKey]
    private var sourceCitiesParameters: [MuseumParameter] = [.apiKey]
    public var museums: [MuseumData] = []
    public var citiesInfo = CitiesInfo()
    public var districtInfo = CitiesInfo()
    weak var delegate: MuseumTableViewModelDelegate?
    var selectedCity: String? {
        didSet {
            print("Kullanıcı şehir değerini güncelleyerek \(selectedCity ?? "") yaptı.")
            selectedDistrict = nil // pickerView da şehir değeri her değiştiğinde ilçe değeri nil olacak.
            sourceCitiesParameters.append(.city(selectedCity ?? ""))
            districtParameters.append(.city(selectedCity ?? ""))
        }
    }
    var selectedDistrict: String? {
        didSet{
            print("Kullanıcı ilçe değerini güncelleyerek \(selectedDistrict ?? "") yaptı.")
            // selectedDistrict property si pickerView dan nil veya boş geldiğinde sourceCitiesParameters değişkenindeki .district() parametresini çıkarır. 
            if let index = sourceCitiesParameters.firstIndex(where: { parameter in
                        if case .district = parameter {
                            return true
                        }
                        return false
                    }) {
                        sourceCitiesParameters.remove(at: index)
                    }
            if let district = selectedDistrict, !district.isEmpty {
                        sourceCitiesParameters.append(.district(district))
                    }
        }
    }
    func fetchCitiesList(){
        dataProvider.fetchCities(endpoint: .cities, parameters: cityParameters) { result in
            switch result {
            case .success(let cities):
                    self.citiesInfo = cities
                self.notify(with: .reloadTableView)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func fetchDistirctList(){
        dataProvider.fetchDistricts(endpoint: .cities, parameters: districtParameters) { result in
            switch result {
            case .success(let district):
                self.districtInfo = district
                self.notify(with: .reloadTableView)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func fetchSourceMuseumList(){
        dataProvider.fetchSourceMuseums(endpoint: .museum, parameters: sourceCitiesParameters) { result in
            switch result {
            case .success(let sourceMuseums):
                if let sourceMuseums = sourceMuseums.data {
                    self.museums = sourceMuseums
                    self.notify(with: .reloadTableView)
                }
                print("Sorgulanan müze sayısı: \(self.museums.count)")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    private func notify(with notify: NotifyViewModel){
        DispatchQueue.main.async {
            self.delegate?.notify(notify)
        }
    }
}

