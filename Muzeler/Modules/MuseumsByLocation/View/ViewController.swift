//
//  ViewController.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import UIKit

enum TableCellType {
    case museums
    case noData
}

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var viewModel = ViewModel()
    private var cellTypes: [TableCellType] = []
    var networkConnect: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMuseumList()
        viewModel.delegate = self
        RegisterCellManager.shared.registerCells(tableViewCell: MuseumTableViewCell.self, tableView: tableView)
        RegisterCellManager.shared.registerCells(tableViewCell: NoDataTableViewCell.self, tableView: tableView)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == SegueIdentifier.MuseumDetailVC.rawValue else { return }
        if let museum = sender as? MuseumData {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.museum = museum
        }
    }
    
    @IBAction func museumsLocationTapped(_ sender: Any) {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SegueIdentifier.MapVC.rawValue) as! MapViewController
        destinationVC.museums = viewModel.museums
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch cellTypes[section] {
        case .museums:
            return viewModel.museums.count
        case .noData:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellTypes[indexPath.section]{
        case .museums:
            let museum = viewModel.museums[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MuseumTableViewCell.self)) as! MuseumTableViewCell
            cell.prepareCell(with: CellViewModel(museum: museum))
            return cell
        case .noData:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoDataTableViewCell.self)) as!
            NoDataTableViewCell
            tableView.separatorStyle = .none
            if indexPath.row == 0 {
                return UITableViewCell()
            } else {
                cell.viewModel = viewModel
                cell.prepareCell(networkStatus: networkConnect)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.museums.count > 0 {
            let museum = viewModel.museums[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: SegueIdentifier.MuseumDetailVC.rawValue, sender: museum)
        }
    }
}

extension ViewController: MuseumTableViewModelDelegate {
    func notify(_ notify: NotifyViewModel) {
        switch notify {
        case .reloadTableView:
            cellTypes = [.museums]
            tableView.reloadData()
        case .error(let museumApiError):
            print(museumApiError.rawValue)
            networkConnect = false
            cellTypes = [.noData]
            tableView.reloadData()
        }
    }
}


