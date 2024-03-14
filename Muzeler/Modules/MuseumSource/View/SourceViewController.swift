//
//  CitiesViewController.swift
//  Muzeler
//
//  Created by Ferhat on 22.02.2024.
//

import UIKit

class SourceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let viewModel = CitiesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCitiesList()
        viewModel.delegate = self
        RegisterCellManager.shared.registerCells(tableViewCell: MuseumTableViewCell.self, tableView: tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == SegueIdentifier.SourceMuseumDetailVC.rawValue else { return }
        if let museum = sender as? MuseumData {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.museum = museum
        }
    }
}
extension SourceViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            let citiesCount = (viewModel.citiesInfo.rowCount ?? 0) + 1
            return citiesCount
        }else {
            let distictCount = (viewModel.districtInfo.rowCount ?? 0) + 1
            return distictCount
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if row == 0 { // veriyi pickerview da istediğim row dan göstermeye başlatabilmem için if sorgusu yapıyorum.
                return ""
            } else {
                return viewModel.citiesInfo.data?[row-1].cities
            }
        }else {
            if row == 0 {
                return ""
            }else {
                return viewModel.districtInfo.data?[row-1].cities
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.selectRow(0, inComponent: 1, animated: true)
            if row != 0 {
                viewModel.selectedCity = viewModel.citiesInfo.data?[row-1].slug
                viewModel.fetchDistirctList()// İlçe seçmek için şehir seçildikten sonra sorgu atıyorum.
                viewModel.fetchSourceMuseumList()
            }else {
                // 0. componentin row değeri eski değerinden 0' a getirildiğinde tableView listesini temizlemesi için selectedCty değerini nil yapsın ve tekrar sorgu atarak tableView u boş döndürsün.
                viewModel.selectedCity = nil
                viewModel.fetchSourceMuseumList()
                // 0. componentin row değeri eski değerinden 0'a getirildiğinde ilçe sorgusu atsın. Böylelikle pickerView daki ilçe listesinin sıfırlanmasını amaçlıyorum.
                viewModel.fetchDistirctList()
            }
        }else {
            if row != 0 {
                viewModel.selectedDistrict = viewModel.districtInfo.data?[row-1].slug
                viewModel.fetchSourceMuseumList()
            }else {
                viewModel.selectedDistrict = nil
                viewModel.fetchSourceMuseumList()
            }
        }
    }
  
}
extension SourceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.museums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let museum = viewModel.museums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MuseumTableViewCell.self)) as! MuseumTableViewCell
        cell.prepareCell(with: CellViewModel(museum: museum))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let museum = viewModel.museums[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIdentifier.SourceMuseumDetailVC.rawValue, sender: museum)
    }
}
extension SourceViewController: MuseumTableViewModelDelegate {
    func notify(_ notify: NotifyViewModel) {
        switch notify {
        case .reloadTableView:
            tableView.reloadData()
            pickerView.reloadAllComponents()
        case .error(let museumApiError):
            print(museumApiError)
        }
    }
}
